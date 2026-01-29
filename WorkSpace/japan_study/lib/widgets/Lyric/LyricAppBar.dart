import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 1. Auth import 추가
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/utils/app_size.dart';

// lib/widgets/Lyric/LyricAppBar.dart
class LyricAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VideoInfo video;
  final bool isSearching;
  final bool isAnalyzing;
  final bool isBookmarked;
  final bool hasLyrics;
  final VoidCallback onSearch;
  final VoidCallback onAnalysis;
  final VoidCallback onBookmarkToggle;

  const LyricAppBar({
    super.key,
    required this.video,
    required this.isSearching,
    required this.isAnalyzing,
    required this.isBookmarked,
    required this.hasLyrics,
    required this.onSearch,
    required this.onAnalysis,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 2. 현재 게스트(비로그인) 상태인지 확인
    final bool isGuest = FirebaseAuth.instance.currentUser == null;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        video.title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        // 1. 가사 검색 버튼
        IconButton(
          icon: isSearching
              ? _buildLoadingIndicator()
              : Icon(
                  Icons.search,
                  // 🔥 3. 게스트면 회색, 아니면 검정색
                  color: isGuest ? Colors.grey.shade300 : Colors.black,
                ),
          // 🔥 4. 게스트면 클릭 불가 (null)
          onPressed: (isSearching || isGuest) ? null : onSearch,
        ),

        // 2. AI 분석 버튼
        IconButton(
          icon: isAnalyzing
              ? _buildLoadingIndicator()
              : Icon(
                  Icons.auto_awesome,
                  // 🔥 5. 게스트면 회색
                  color: isGuest ? Colors.grey.shade300 : Colors.black,
                ),
          // 🔥 6. 게스트면 클릭 불가 (null)
          onPressed: (isAnalyzing || !hasLyrics || isGuest) ? null : onAnalysis,
        ),

        // 3. 즐겨찾기 (즐겨찾기는 로컬 DB라 게스트도 가능하므로 유지)
        IconButton(
          icon: Icon(
            isBookmarked ? Icons.favorite : Icons.favorite_border,
            color: isBookmarked ? Colors.red : Colors.black,
          ),
          onPressed: onBookmarkToggle,
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 20.w,
      height: 20.w,
      child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
