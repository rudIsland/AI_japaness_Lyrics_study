import 'package:flutter/material.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/utils/app_size.dart';
import 'package:japan_study/widgets/Youtube/YoutubePlayerWidget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LyricAudioPlayerCard extends StatelessWidget {
  final VideoInfo video;
  final YoutubePlayerController controller;
  final bool isPlaying;
  final VoidCallback onTogglePlay;

  const LyricAudioPlayerCard({
    super.key,
    required this.video,
    required this.controller,
    required this.isPlaying,
    required this.onTogglePlay,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 15.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: 1,
              height: 1,
              child: YoutubePlayerWidget(
                videoId: video.youtubeVideoId,
                controller: controller,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.w),
                  image: DecorationImage(
                    image: NetworkImage(video.thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      video.artist,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ValueListenableBuilder(
                      valueListenable: controller,
                      builder: (context, value, child) {
                        final total = value.metaData.duration;
                        final current = value.position;
                        return Column(
                          children: [
                            LinearProgressIndicator(
                              value: total.inSeconds > 0
                                  ? current.inSeconds / total.inSeconds
                                  : 0,
                              backgroundColor: Colors.grey.shade100,
                              valueColor: const AlwaysStoppedAnimation(
                                Colors.red,
                              ),
                              minHeight: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(current),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  _formatDuration(total),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_filled_rounded,
                  color: Colors.red,
                  size: 42.w,
                ),
                onPressed: onTogglePlay,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
