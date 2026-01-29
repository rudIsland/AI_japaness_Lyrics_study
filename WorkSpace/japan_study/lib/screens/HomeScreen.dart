import 'package:flutter/material.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/utils/app_size.dart';
import 'package:japan_study/widgets/Home/HomeSearchBar.dart';
import 'package:japan_study/widgets/Home/HomeSongGrid.dart';
import 'package:japan_study/widgets/Home/HomeStudyProgress.dart';

class HomeScreen extends StatefulWidget {
  final Function(VideoInfo) onSongSelected;
  final String? playingVideoId;

  const HomeScreen({
    super.key,
    required this.onSongSelected,
    this.playingVideoId,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          // 🔥 Stack을 사용하여 검색창이 항상 그리드 위에 오도록 합니다. [cite: 2026-01-22]
          child: Stack(
            children: [
              // 1. 배경 콘텐츠 (그리드, 공부 할당량)
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 검색창이 차지할 공간만큼 비워줍니다. [cite: 2026-01-22]
                      SizedBox(height: 60.h),
                      HomeSongGrid(
                        playingVideoId: widget.playingVideoId,
                        onSongTap: (video) async {
                          // 1. 공부 화면으로 이동 (여기서 await로 대기)
                          await widget.onSongSelected(video);

                          // 2. 돌아왔을 때 화면 갱신!
                          // 부모가 다시 그려지면 -> 자식(Progress)도 다시 그려짐
                          // -> StreamBuilder가 다시 실행되며 최신 DB값을 가져옴
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                      HomeStudyProgress(),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),

              // 2. 검색 바 (Stack의 마지막에 배치하여 가장 앞에 보이게 함) [cite: 2026-01-22]
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color:
                      Colors.white, // 뒤쪽 콘텐츠가 비치지 않게 배경색 추가 [cite: 2026-01-22]
                  child: HomeSearchBar(onSongSelected: widget.onSongSelected),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
