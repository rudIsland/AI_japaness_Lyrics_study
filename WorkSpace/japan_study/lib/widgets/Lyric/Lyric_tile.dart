import 'package:flutter/material.dart';
import 'package:ruby_text/ruby_text.dart';
import 'package:japan_study/Models/Lyric.dart'; // ✅ Models 대문자 반영
import 'package:japan_study/utils/app_size.dart';

class LyricTile extends StatelessWidget {
  final Lyric lyric;
  final bool showFurigana;
  final bool showTranslation;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const LyricTile({
    super.key,
    required this.lyric,
    required this.showFurigana,
    required this.showTranslation,
    required this.isActive,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 일본어 원문 + 후리가나 (상단 배치) - 원래 로직 유지
            RubyText(
              lyric.rubyText,
              textAlign: TextAlign.left,
              rubyStyle: TextStyle(
                color: showFurigana
                    ? Colors.blue
                    : Colors.transparent, // 파란색 유지
                fontSize: 10.sp,
                height: 1.2,
              ),
              style: TextStyle(
                color: isActive ? Colors.red : Colors.black,
                fontSize: 17.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),

            // 2. 한국어 번역 (하단 배치) - 원래 로직 유지
            if (showTranslation && lyric.translation.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Text(
                  lyric.translation,
                  style: TextStyle(
                    color: isActive
                        ? Colors.red.withValues(alpha: 0.7)
                        : Colors.grey.shade500,
                    fontSize: 13.sp,
                  ),
                ),
              ),

            // 힌트 아이콘 로직 유지
            if (lyric.notes.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.info_outline,
                  size: 14.sp,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
