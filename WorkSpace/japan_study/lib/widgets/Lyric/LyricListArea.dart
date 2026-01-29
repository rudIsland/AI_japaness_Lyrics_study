// lib/widgets/Lyric/LyricListArea.dart
import 'package:flutter/material.dart';
import 'package:japan_study/Models/Lyric.dart'; // ✅ Models 대문자 반영
import 'package:japan_study/widgets/Lyric/Lyric_tile.dart';
import 'package:japan_study/utils/app_size.dart';

class LyricListArea extends StatelessWidget {
  final bool isLoading;
  final List<Lyric> lyrics;
  final ScrollController scrollController;
  final List<GlobalKey> lyricKeys;
  final int activeIndex;
  final bool showFurigana;
  final bool showTranslation;
  final VoidCallback onSearchPressed;
  final Function(int index) onLyricTap;
  final Function(Lyric lyric) onLyricLongPress;

  const LyricListArea({
    super.key,
    required this.isLoading,
    required this.lyrics,
    required this.scrollController,
    required this.lyricKeys,
    required this.activeIndex,
    required this.showFurigana,
    required this.showTranslation,
    required this.onSearchPressed,
    required this.onLyricTap,
    required this.onLyricLongPress,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 로딩 중일 때
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }

    // 2. 가사 데이터가 없을 때
    if (lyrics.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "가사 데이터가 없습니다.",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: onSearchPressed,
              icon: const Icon(Icons.search),
              label: const Text("가사 찾기"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    // 3. 가사 목록 렌더링
    return ListView.builder(
      controller: scrollController,
      itemCount: lyrics.length,
      padding: EdgeInsets.only(bottom: 20.h),
      itemBuilder: (context, index) {
        final lyric = lyrics[index];

        return LyricTile(
          key: lyricKeys[index],
          lyric: lyric,
          showFurigana: showFurigana,
          showTranslation: showTranslation,
          isActive: (index == activeIndex),
          // ✅ 개별 타일은 부모로부터 받은 콜백을 실행만 합니다.
          onTap: () => onLyricTap(index),
          onLongPress: () => onLyricLongPress(lyric),
        );
      },
    );
  }
}
