import 'package:flutter/material.dart';
import 'package:japan_study/utils/app_size.dart';
import 'package:japan_study/Models/VideoInfo.dart';

class FrequentlySongGrid extends StatelessWidget {
  final List<VideoInfo> songs;
  final PageController controller;
  final Function(int) onPageChanged;
  final Function(VideoInfo) onSongTap;
  final String? playingVideoId;

  const FrequentlySongGrid({
    super.key,
    required this.songs,
    required this.controller,
    required this.onPageChanged,
    required this.onSongTap,
    this.playingVideoId,
  });

  @override
  Widget build(BuildContext context) {
    int pageCount = (songs.length / 9).ceil();
    if (pageCount == 0) pageCount = 1;

    return SizedBox(
      height: 350.h,
      child: PageView.builder(
        controller: controller,
        onPageChanged: onPageChanged,
        itemCount: pageCount,
        itemBuilder: (context, pageIndex) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
              childAspectRatio: 1.0,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final int songIndex = pageIndex * 9 + index;
              if (songIndex < songs.length) {
                return _buildGridItem(songs[songIndex]);
              }
              return _buildEmptySlot();
            },
          );
        },
      ),
    );
  }

  Widget _buildGridItem(VideoInfo song) {
    final bool isPlaying = song.youtubeVideoId == playingVideoId;

    return GestureDetector(
      onTap: () => onSongTap(song),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          border: isPlaying
              ? Border.all(color: Colors.blue, width: 3.w)
              : Border.all(color: Colors.transparent, width: 3.w),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9.w),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 썸네일 표시
              _buildThumbnail(song.thumbnailUrl),
              // 그라데이션 오버레이
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        // Flutter 3.22+ API 사용 (하위 버전은 withOpacity 사용 필요)
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // 곡 정보 텍스트
              Positioned(
                left: 8.w,
                right: 8.w,
                bottom: 8.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      song.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 9.sp, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(String? url) {
    if (url == null || url.isEmpty) {
      return Container(color: Colors.grey.shade200);
    }
    return Image.network(url, fit: BoxFit.cover);
  }

  Widget _buildEmptySlot() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Icon(Icons.add, color: Colors.grey.shade200, size: 24.w),
    );
  }
}
