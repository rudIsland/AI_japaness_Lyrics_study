import 'package:flutter/material.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/utils/app_size.dart';

class SongCard extends StatelessWidget {
  final VideoInfo video;
  final bool isPlaceholder;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress; // 🔥 롱 프레스 콜백 추가

  const SongCard({
    super.key,
    required this.video,
    this.isPlaceholder = false,
    this.onTap,
    this.onLongPress, // 생성자 추가
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.w),
        child: Stack(
          children: [
            _buildBackground(),
            if (!isPlaceholder) _buildTextOverlay(),
            if (!isPlaceholder)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    onLongPress: onLongPress, // 🔥 InkWell에 롱 프레스 연결
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 썸네일 이미지를 배경으로 꽉 채웁니다.
  Widget _buildBackground() {
    if (isPlaceholder) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade50,
        child: Icon(Icons.add, color: Colors.grey.shade200, size: 24.w),
      );
    }

    // ✅ 변수에 담아 null 체크를 수행하여 '!'를 없앱니다.
    final String? imageUrl = video.thumbnailUrl;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade200,
      child: (imageUrl != null && imageUrl.isNotEmpty)
          ? Image.network(
              imageUrl, // ✅ '!' 제거
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.music_note,
                color: Colors.grey.shade400,
                size: 32.w,
              ),
            )
          : Icon(Icons.music_note, color: Colors.grey.shade400, size: 32.w),
    );
  }

  Widget _buildTextOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // 가독성을 위해 검정색 농도를 약간 높였습니다.
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              video.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              video.artist,
              style: TextStyle(color: Colors.white70, fontSize: 9.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
