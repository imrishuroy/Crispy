import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'video_items.dart';

class ExampleVideoPlayer extends StatelessWidget {
  const ExampleVideoPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flutter Video Player Demo'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          VideoItems(
            // videoPlayerController: VideoPlayerController.asset(
            //   'assets/videos/video_6.mp4',
            // ),
            videoPlayerController: VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_2.mp4?alt=media&token=ee3ea1aa-1199-4026-85a3-86e5667bb39e'),
            looping: true,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_4.mp4?alt=media&token=16217058-36bf-4d75-9f90-f2068e1882ef'),
            // 'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'),
            looping: false,
            autoplay: true,
          ),
          VideoItems(
            // videoPlayerController: VideoPlayerController.asset(
            //   'assets/videos/video_3.mp4',
            // ),
            videoPlayerController: VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_1.mp4?alt=media&token=94f21bba-db5f-457a-9b2e-e690788ab51a'),
            looping: false,
            autoplay: false,
          ),
          VideoItems(
            // videoPlayerController: VideoPlayerController.asset(
            //   'assets/videos/video_2.mp4',
            // ),
            videoPlayerController: VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_3.mp4?alt=media&token=c24eb5bd-15c2-4e0a-8803-04d65f8aa319'),
            looping: false,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
                'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'),
            looping: true,
            autoplay: false,
          ),
        ],
      ),
    );
  }
}
