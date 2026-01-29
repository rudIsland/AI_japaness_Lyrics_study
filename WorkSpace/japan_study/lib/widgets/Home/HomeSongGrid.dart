import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 1. 추가
import 'package:japan_study/database/RudDatabase.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/widgets/FrequentlySongGrid.dart';
import 'package:japan_study/utils/app_size.dart';

class HomeSongGrid extends StatefulWidget {
  final String? playingVideoId;
  final Function(VideoInfo) onSongTap;

  const HomeSongGrid({super.key, this.playingVideoId, required this.onSongTap});

  @override
  State<HomeSongGrid> createState() => _HomeSongGridState();
}

class _HomeSongGridState extends State<HomeSongGrid> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // 🔥 2. [Outer Stream] 로그인 상태 감지 (로그아웃 시 즉시 반응)
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        // 🔥 3. [Inner Stream] 상태가 변할 때마다 DB 스트림을 새로 연결
        // 로그아웃 하면 RudDatabase().getFrequentlyVideos()가 빈 리스트 스트림을 반환하므로 화면이 비워짐
        return StreamBuilder<List<VideoInfo>>(
          stream: RudDatabase().getFrequentlyVideos(),
          builder: (context, snapshot) {
            final songs = snapshot.data ?? [];
            int pageCount = songs.length > 9 ? (songs.length / 9).ceil() : 1;

            // 데이터가 로딩 중이거나 없을 때도 UI 틀어짐 방지 (선택 사항)
            // if (!snapshot.hasData) return const SizedBox();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader("자주 듣는 곡"),
                FrequentlySongGrid(
                  songs: songs,
                  playingVideoId: widget.playingVideoId,
                  controller: _pageController,
                  onSongTap: widget.onSongTap,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                ),
                // 페이지가 2개 이상일 때만 인디케이터 표시
                if (pageCount > 1) _buildIndicator(pageCount),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(String title) => Padding(
    padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 15.h),
    child: Text(
      title,
      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildIndicator(int count) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      count,
      (idx) => Container(
        width: 8.w,
        height: 8.w,
        margin: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == idx ? Colors.red : Colors.red.withOpacity(0.2),
        ),
      ),
    ),
  );
}
