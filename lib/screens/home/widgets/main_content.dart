import 'package:flutter/material.dart';

import 'action_toolbar.dart';
import 'full_screen_video.dart';
import 'video_description.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MainContentLayout(),
      ],
    );
  }
}

class MainContentLayout extends StatelessWidget {
  final List<String> videoUrls = [
    'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_2.mp4?alt=media&token=ee3ea1aa-1199-4026-85a3-86e5667bb39e',
    'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_4.mp4?alt=media&token=16217058-36bf-4d75-9f90-f2068e1882ef',
    'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_1.mp4?alt=media&token=94f21bba-db5f-457a-9b2e-e690788ab51a',
    'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_3.mp4?alt=media&token=c24eb5bd-15c2-4e0a-8803-04d65f8aa319',
    'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/video_6.mp4?alt=media&token=59ba9290-dc8d-43da-965c-b044e224f827',
    // 'assets/videos/video1.mp4',
    // 'assets/videos/video2.mp4',
    // 'assets/videos/video_6.mp4',
    // 'assets/videos/video_1.mp4',
    // 'assets/videos/video_3.mp4',
  ];

  MainContentLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      // children: List.generate(5, (index) {
      //   return const ContentView();
      // }),
      children:
          videoUrls.map((String url) => ContentView(videoUrl: url)).toList(),
    );
  }
}

class ContentView extends StatelessWidget {
  final String videoUrl;

  const ContentView({Key? key, required this.videoUrl}) : super(key: key);

  Widget get middleSection => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            VideoDescription(),
            ActionsToolbar(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),

          // padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FullScreenVideo(
              videoUrl: videoUrl,
            ),
          ),
        ),
        //middleSection,
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              VideoDescription(),
              ActionsToolbar(),
            ],
          ),
        ),
      ],
    );
  }
}

class SideActions extends StatelessWidget {
  const SideActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
