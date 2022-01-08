import 'package:better_player/better_player.dart';
import '/config/contants.dart';
import '/models/video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OutletListWidget extends StatefulWidget {
  final VideoListData? videoListData;

  const OutletListWidget({Key? key, this.videoListData}) : super(key: key);

  @override
  _OutletListWidgetState createState() => _OutletListWidgetState();
}

class _OutletListWidgetState extends State<OutletListWidget> {
  VideoListData? get videoListData => widget.videoListData;
  late BetterPlayerConfiguration betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    betterPlayerConfiguration = BetterPlayerConfiguration(
      errorBuilder: (context, error) {
        return Center(
          child: Text(
            error ?? 'Something went wrong :(',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
      autoPlay: true,
      looping: true,
      aspectRatio: 0.5,
      handleLifecycle: true,
      showPlaceholderUntilPlay: false,
      autoDispose: false,
      controlsConfiguration: const BetterPlayerControlsConfiguration(
        enablePlayPause: false,
        showControlsOnInitialize: false,
        // controlsHideTime: Duration(seconds: 0),
        // showControls: true,
        enableProgressBarDrag: false,
        enableProgressText: false,
        enableProgressBar: false,
        enableSkips: false,
        enableRetry: false,

        enableAudioTracks: false,
        enableMute: false,
        enableSubtitles: false,
        //enableFullscreen: ,
        enableQualities: false,
        enableOverflowMenu: false,
        enablePlaybackSpeed: false,
        enablePip: false,

        loadingWidget: Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: SpinKitChasingDots(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.pause();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayerListVideoPlayer(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoListData?.videoUrl ?? errorVideo,
        notificationConfiguration: BetterPlayerNotificationConfiguration(
            showNotification: false,
            title: videoListData?.videoTitle,
            author: 'Test'),
        bufferingConfiguration: const BetterPlayerBufferingConfiguration(
          minBufferMs: 2000,
          maxBufferMs: 10000,
          bufferForPlaybackMs: 1000,
          bufferForPlaybackAfterRebufferMs: 2000,
        ),
      ),
      configuration: betterPlayerConfiguration,
      playFraction: 0.8,
      betterPlayerListVideoPlayerController: controller,
    );
  }
}
