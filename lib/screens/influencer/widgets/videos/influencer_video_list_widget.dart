import 'package:better_player/better_player.dart';
import 'package:crispy/config/contants.dart';

import 'package:crispy/models/video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InfluencerListVideoWidget extends StatefulWidget {
  final VideoListData? videoListData;

  const InfluencerListVideoWidget({Key? key, this.videoListData})
      : super(key: key);

  @override
  _InfluencerListVideoWidgetState createState() =>
      _InfluencerListVideoWidgetState();
}

class _InfluencerListVideoWidgetState extends State<InfluencerListVideoWidget> {
  VideoListData? get videoListData => widget.videoListData;
  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
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
      configuration: const BetterPlayerConfiguration(
        autoPlay: true,
        aspectRatio: 0.5,
        handleLifecycle: true,
        showPlaceholderUntilPlay: false,
        autoDispose: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: false,
          showControls: false,
          enableProgressBarDrag: false,
          enableProgressText: false,
          enableProgressBar: false,
          enableSkips: false,
          enableAudioTracks: false,
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
      ),

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
