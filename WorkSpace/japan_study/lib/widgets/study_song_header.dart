import 'package:flutter/material.dart';
import 'package:japan_study/utils/app_size.dart';

class SongHeader extends StatelessWidget {
  final String title;
  final String artist;
  final bool isFavorite;
  final VoidCallback onTapFavorite;

  const SongHeader({
    super.key,
    required this.title,
    required this.artist,
    required this.isFavorite,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 4.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Icon(Icons.music_note, color: Colors.pink, size: 20.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  artist,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onTapFavorite,
            icon: Icon(
              isFavorite ? Icons.bookmark : Icons.bookmark_border,
              // 🔥 즐겨찾기 활성화 시 노란색(amber)으로 표시합니다.
              color: isFavorite ? Colors.amber : Colors.grey.shade400,
              size: 24.w,
            ),
          ),
        ],
      ),
    );
  }
}
