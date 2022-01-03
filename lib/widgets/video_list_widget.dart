import 'package:better_player/better_player.dart';
import 'package:crispy/config/contants.dart';
import 'package:crispy/models/video_list.dart';

import 'package:flutter/material.dart';

class VideoListWidget extends StatefulWidget {
  final VideoListData? videoListData;

  const VideoListWidget({Key? key, this.videoListData}) : super(key: key);

  @override
  _VideoListWidgetState createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  VideoListData? get videoListData => widget.videoListData;
  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    // betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
    betterPlayerConfiguration =
        const BetterPlayerConfiguration(autoPlay: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      child: BetterPlayerListVideoPlayer(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          videoListData?.videoUrl ?? errorVideo,
          notificationConfiguration: BetterPlayerNotificationConfiguration(
            showNotification: false,
            title: videoListData!.videoTitle,
            author: 'Test',
          ),
          bufferingConfiguration: const BetterPlayerBufferingConfiguration(
              minBufferMs: 2000,
              maxBufferMs: 10000,
              bufferForPlaybackMs: 1000,
              bufferForPlaybackAfterRebufferMs: 2000),
        ),
        configuration: const BetterPlayerConfiguration(
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enablePlayPause: false,
            enableProgressBarDrag: false,
            //enableMute: false,
            enableProgressText: false,
            enableProgressBar: false,
            enableSkips: false,
            enableAudioTracks: false,
          ),
          autoPlay: true,
          aspectRatio: 0.5,
          looping: true,
          handleLifecycle: true,
          autoDispose: false,
        ),
        //key: Key(videoListData.hashCode.toString()),
        playFraction: 0.8,
        betterPlayerListVideoPlayerController: controller,
      ),
      aspectRatio: 1,
    );
  }
}
