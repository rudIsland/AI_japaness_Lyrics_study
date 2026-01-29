import 'package:flutter/material.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/screens/HomeScreen.dart';
import 'package:japan_study/screens/StudiedListScreen.dart';
import 'package:japan_study/screens/FavoriteListScreen.dart';
import 'package:japan_study/screens/LyricDetailScreen.dart';
import 'package:japan_study/utils/app_size.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  // 🔥 PageView를 제어하기 위한 컨트롤러
  final PageController _pageController = PageController();

  Future<void> _onPlaySong(VideoInfo video) async {
    // 1. 화면 이동 및 대기 (공부 끝나고 닫힐 때까지 멈춤)
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LyricDetailScreen(video: video)),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);

    return Scaffold(
      // 🔥 옆으로 넘기는 기능을 위해 다시 PageView 사용
      body: PageView(
        controller: _pageController,
        // 사용자가 손으로 스와이프했을 때 하단 탭도 같이 바뀌게 함
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: [
          // ⚠️ 주의: PageView 안에서는 이 화면들이 안 보이면 파괴됩니다.
          // 파괴를 막으려면 각 화면(HomeScreen, StudiedListScreen)에
          // 'KeepAlive' 딱지를 붙여야 합니다. (아래 2번 코드 참고)
          HomeScreen(onSongSelected: _onPlaySong),
          StudiedListScreen(onSongSelected: _onPlaySong),
          FavoriteListScreen(onSongSelected: _onPlaySong),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // 탭을 눌렀을 때 해당 페이지로 부드럽게 이동 (애니메이션 제거하려면 jumpToPage)
          _pageController.jumpToPage(index);
        },
        selectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "기록"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "즐겨찾기"),
        ],
      ),
    );
  }
}
