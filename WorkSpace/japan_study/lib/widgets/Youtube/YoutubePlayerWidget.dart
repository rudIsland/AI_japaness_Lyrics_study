import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:japan_study/utils/app_size.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String videoId;
  // RUD: 부모 위젯에서 제어하기 위해 주입받는 컨트롤러
  final YoutubePlayerController controller;

  const YoutubePlayerWidget({
    super.key,
    required this.videoId,
    required this.controller,
  });

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12.w),
      ),
      clipBehavior: Clip.antiAlias, // 모서리 둥글게 적용
      child: YoutubePlayer(
        controller: widget.controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
      ),
    );
  }
}
