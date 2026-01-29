import 'package:flutter/material.dart';
import 'package:japan_study/database/RudDatabase.dart';
import 'package:japan_study/widgets/song_card.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/utils/app_size.dart';

class FavoriteListScreen extends StatelessWidget {
  // 🔥 재생 연동을 위한 파라미터 추가
  final Function(VideoInfo) onSongSelected;
  final String? playingVideoId;

  const FavoriteListScreen({
    super.key,
    required this.onSongSelected,
    this.playingVideoId,
  });

  void _showUnfavoriteDialog(BuildContext context, VideoInfo video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("즐겨찾기 해제"),
        content: Text("'${video.title}' 곡을 즐겨찾기 목록에서 삭제할까요?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await RudDatabase().updateFavoriteStatus(video, false);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("삭제", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context); // 반응형 대응

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "즐겨찾기",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<VideoInfo>>(
        future: RudDatabase().getFavoriteVideos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("즐겨찾기한 곡이 없습니다."));
          }

          final songs = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(15.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.0,
            ),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              final bool isPlaying = song.youtubeVideoId == playingVideoId;

              // 🔥 SongCard를 감싸서 테두리 강조 처리
              return GestureDetector(
                onLongPress: () => _showUnfavoriteDialog(context, song),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    border: isPlaying
                        ? Border.all(color: Colors.blue, width: 3.w)
                        : null,
                  ),
                  child: SongCard(
                    video: song,
                    onTap: () => onSongSelected(song), // 🔥 부모의 재생 함수 호출
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
