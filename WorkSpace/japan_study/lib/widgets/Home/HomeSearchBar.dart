import 'package:flutter/material.dart';
import 'dart:async';
import 'package:japan_study/Service/Youtube/YoutubeSearcher.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/widgets/SearchRecommendList.dart';
import 'package:japan_study/widgets/Home/UserProfileButton.dart';
import 'package:japan_study/screens/YoutubeSearchScreen.dart';
import 'package:japan_study/Service/User_Auth/AuthService.dart';
import 'package:japan_study/utils/app_size.dart';

class HomeSearchBar extends StatefulWidget {
  final Function(VideoInfo) onSongSelected;

  const HomeSearchBar({super.key, required this.onSongSelected});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final YoutubeSearcher _searcher = YoutubeSearcher();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<String> _recommendTexts = [];
  bool _showRecommend = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _showRecommend =
            _searchFocusNode.hasFocus && _recommendTexts.isNotEmpty;
      });
    });
  }

  void _handleSearchInput(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (text.isEmpty) {
        setState(() {
          _recommendTexts = [];
          _showRecommend = false;
        });
        return;
      }
      final hints = await _searcher.getRecommendTexts(text);
      setState(() {
        _recommendTexts = hints;
        _showRecommend = _searchFocusNode.hasFocus && hints.isNotEmpty;
      });
    });
  }

  void _executeSearch(String query) async {
    if (query.isEmpty) return;
    _searchFocusNode.unfocus();
    _debounce?.cancel();

    setState(() {
      _showRecommend = false;
      _recommendTexts = [];
    });

    final VideoInfo? selected = await Navigator.push<VideoInfo>(
      context,
      MaterialPageRoute(
        builder: (context) => YoutubeSearchScreen(query: query),
      ),
    );

    if (selected != null) widget.onSongSelected(selected);
    _searchController.clear();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "계정 설정",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("현재 로그인된 계정에서 로그아웃 하시겠습니까?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          ElevatedButton(
            onPressed: () {
              AuthService().signOut();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("로그아웃", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack 대신 Column을 사용하여 자식들이 모두 터치 가능한 영역에 있게 합니다.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 15.w, 0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: _handleSearchInput,
                    onSubmitted: _executeSearch,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: "노래 제목이나 가수를 검색하세요",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              UserProfileButton(onLogoutRequested: _showLogoutDialog),
            ],
          ),
        ),
        // Positioned 대신 Column의 자식으로 배치하여 터치 이벤트를 정상 수신하게 합니다.
        if (_showRecommend && _recommendTexts.isNotEmpty)
          SearchRecommendList(
            hints: _recommendTexts,
            onSelected: _executeSearch, // 이제 클릭 시 정상적으로 실행됩니다.
          ),
      ],
    );
  }
}
