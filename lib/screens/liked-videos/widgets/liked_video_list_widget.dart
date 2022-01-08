import 'package:better_player/better_player.dart';
import '/config/contants.dart';
import '/models/video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LikedVideoListWidget extends StatefulWidget {
  final VideoListData? videoListData;

  const LikedVideoListWidget({Key? key, this.videoListData}) : super(key: key);

  @override
  _LikedVideoListWidgetState createState() => _LikedVideoListWidgetState();
}

class _LikedVideoListWidgetState extends State<LikedVideoListWidget> {
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

      //key: Key(videoListData.hashCode.toString()),
      playFraction: 0.8,

      betterPlayerListVideoPlayerController: controller,
    );

    // Card(
    //   margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Padding(
    //       //   padding: EdgeInsets.all(8),
    //       //   child: Text(
    //       //     videoListData!.videoTitle,
    //       //     style: TextStyle(fontSize: 50),
    //       //   ),
    //       // ),
    //       BetterPlayerListVideoPlayer(
    //         BetterPlayerDataSource(
    //           BetterPlayerDataSourceType.network,
    //           videoListData!.videoUrl,
    //           notificationConfiguration: BetterPlayerNotificationConfiguration(
    //               showNotification: false,
    //               title: videoListData!.videoTitle,
    //               author: 'Test'),
    //           bufferingConfiguration: const BetterPlayerBufferingConfiguration(
    //               minBufferMs: 2000,
    //               maxBufferMs: 10000,
    //               bufferForPlaybackMs: 1000,
    //               bufferForPlaybackAfterRebufferMs: 2000),
    //         ),
    //         configuration: const BetterPlayerConfiguration(
    //             autoPlay: false, aspectRatio: 1, handleLifecycle: true),
    //         //key: Key(videoListData.hashCode.toString()),
    //         playFraction: 0.8,
    //         betterPlayerListVideoPlayerController: controller,
    //       ),
    //       // const Padding(
    //       //   padding: EdgeInsets.all(8),
    //       //   child: Text(
    //       //       "Horror: In Steven Spielberg's Jaws, a shark terrorizes a beach "
    //       //       "town. Plainspoken sheriff Roy Scheider, hippie shark "
    //       //       "researcher Richard Dreyfuss, and a squirrely boat captain "
    //       //       "set out to find the beast, but will they escape with their "
    //       //       "lives? 70's special effects, legendary score, and trademark "
    //       //       "humor set this classic apart."),
    //       // ),
    //       // Center(
    //       //   child: Wrap(children: [
    //       //     ElevatedButton(
    //       //       child: Text("Play"),
    //       //       onPressed: () {
    //       //         controller!.play();
    //       //       },
    //       //     ),
    //       //     const SizedBox(width: 8),
    //       //     ElevatedButton(
    //       //       child: Text("Pause"),
    //       //       onPressed: () {
    //       //         controller!.pause();
    //       //       },
    //       //     ),
    //       //     const SizedBox(width: 8),
    //       //     ElevatedButton(
    //       //       child: Text("Set max volume"),
    //       //       onPressed: () {
    //       //         controller!.setVolume(100);
    //       //       },
    //       //     ),
    //       //   ]),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
