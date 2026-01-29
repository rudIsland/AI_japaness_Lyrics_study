import 'dart:async'; // 🔥 1. 추가 (StreamSubscription용)
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 2. 추가 (로그인 감지용)
import 'package:flutter/material.dart';
import 'package:japan_study/database/RudDatabase.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/Models/Display/StudiedVideoUI.dart';
import 'package:japan_study/utils/app_size.dart';
import 'package:intl/intl.dart';

class StudiedListScreen extends StatefulWidget {
  final Function(VideoInfo) onSongSelected;
  final String? playingVideoId;

  const StudiedListScreen({
    super.key,
    required this.onSongSelected,
    this.playingVideoId,
  });

  @override
  State<StudiedListScreen> createState() => _StudiedListScreenState();
}

class _StudiedListScreenState extends State<StudiedListScreen>
    with AutomaticKeepAliveClientMixin {
  late Stream<List<StudiedVideoUI>> _studiesStream;

  // 🔥 3. 감시자 변수 선언
  StreamSubscription? _authListener;

  @override
  void initState() {
    super.initState();

    // 처음 화면 켤 때 연결
    _studiesStream = RudDatabase().getStudiedVideosUI();

    // 🔥 4. [핵심] 로그인/로그아웃 감지기 설치
    // 평소엔 가만히 있다가, '로그인 상태'가 변하면 즉시 발동해서 DB를 새로 연결합니다.
    _authListener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {
          // RudDatabase가 reset() 되었다면, 여기서 새로운 DB 스트림을 가져옵니다.
          _studiesStream = RudDatabase().getStudiedVideosUI();
          print("UI: 로그인 상태 변경됨 -> DB 스트림 새로고침 완료");
        });
      }
    });
  }

  @override
  void dispose() {
    // 🔥 5. 화면 꺼질 때 감시자 해고 (메모리 누수 방지)
    _authListener?.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true; // 탭 이동 시 화면 유지

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<List<StudiedVideoUI>>(
          stream: _studiesStream, // 감지기가 교체해준 최신 스트림을 사용
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("Error: ${snapshot.error}"));
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "공부한 기록이 없습니다.",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            final results = snapshot.data!;
            Map<String, List<StudiedVideoUI>> groupedRecords = {};
            for (var item in results) {
              String dateKey = DateFormat('M월 d일').format(item.studiedAt);
              groupedRecords.putIfAbsent(dateKey, () => []).add(item);
            }

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildMainTitle(),
                ...groupedRecords.entries.map(
                  (entry) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDateHeader(entry.key),
                      ...entry.value.map(
                        (item) => _buildStudyItem(context, item, results),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ... (아래 _buildStudyItem, _buildMainTitle 등 디자인 코드는 기존과 완벽히 동일)
  Widget _buildStudyItem(
    BuildContext context,
    StudiedVideoUI item,
    List<StudiedVideoUI> allItems,
  ) {
    final bool isPlaying = item.video.youtubeVideoId == widget.playingVideoId;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      tileColor: isPlaying ? Colors.blue.withOpacity(0.05) : null,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Image.network(
          item.video.thumbnailUrl,
          width: 50.w,
          height: 50.w,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) =>
              Container(color: Colors.grey[200], width: 50.w, height: 50.w),
        ),
      ),
      title: Text(
        item.video.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14.sp,
          color: isPlaying ? Colors.blue : Colors.black,
        ),
      ),
      subtitle: Text(item.video.artist, style: TextStyle(fontSize: 12.sp)),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              final newStatus = !item.isFavorite;
              final targetId = item.video.youtubeVideoId;

              // DB 업데이트 (백그라운드)
              RudDatabase().updateFavoriteStatus(item.video, newStatus);

              // 4. [핵심] 화면에 있는 모든 항목 중 ID가 같은 것을 찾아 일괄 변경
              setState(() {
                for (var row in allItems) {
                  if (row.video.youtubeVideoId == targetId) {
                    row.isFavorite = newStatus;
                  }
                }
              });
            },
            icon: Icon(
              item.isFavorite ? Icons.bookmark : Icons.bookmark_border,
              color: item.isFavorite ? Colors.amber : Colors.grey.shade400,
            ),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context, item.recordId),
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
          ),
        ],
      ),
      onTap: () => widget.onSongSelected(item.video),
    );
  }

  Widget _buildMainTitle() => Padding(
    padding: EdgeInsets.all(25.w),
    child: const Text(
      "최근 공부한 곡",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
  Widget _buildDateHeader(String date) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.w),
    child: Text(date, style: const TextStyle(color: Colors.red)),
  );

  void _showDeleteDialog(BuildContext context, int? recordId) {
    if (recordId == null) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("기록 삭제"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              RudDatabase().deleteStudiedRecord(recordId);
              Navigator.pop(context);
            },
            child: const Text("삭제", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
