import '/screens/home/bloc/video_bloc.dart';
import '/screens/liked-videos/liked_videos.dart';

import '/screens/influencer/influencer_profile.dart';
import '/screens/map/map_screen.dart';
import 'package:flutter/material.dart';

import 'action_toolbar.dart';
import 'full_screen_video.dart';
import 'video_description.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    //   final _videoRepo = context.read<VideoRepository>();
    return BlocConsumer<VideoBloc, VideoState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case VideoStatus.succuss:
            final videos = state.videos;
            return PageView.builder(itemBuilder: (context, index) {
              final video = videos[index];
              return ContentView(videoUrl: video?.videoUrl);
            });

          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }

        // if (state.status == VideoStatus.succuss) {
        //   final videos = state.videos;
        //   return PageView.builder(itemBuilder: (context, index) {
        //     final video = videos[index];
        //     return ContentView(videoUrl: video?.videoUrl);
        //   });
        // }
      },
    );

    // FutureBuilder<List<Video?>>(
    //   future: _videoRepo.getVideos(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );

    //  PageView(
    //   scrollDirection: Axis.vertical,
    //   // children: List.generate(5, (index) {
    //   //   return const ContentView();
    //   // }),
    //   children:
    //       videoUrls.map((String url) => ContentView(videoUrl: url)).toList(),
    // );
  }
}

class ContentView extends StatelessWidget {
  final String? videoUrl;

  ContentView({Key? key, required this.videoUrl}) : super(key: key);

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

  // number is irrelevant
// final initialPage = (
//     .161251195141521521142025 // :)
//     * 1e6).round();
// final itemCount = getSomeItemCount();

  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return PageView(
      reverse: true,
      controller: _pageController,
      children: [
        // const Scaffold(
        //   body: Center(child: Text('Maps Screen')),
        // ),
        const MapScreen(),
        Stack(
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
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  VideoDescription(),
                  ActionsToolbar(),
                ],
              ),
            ),

            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.only(right: 20.0, top: 7.0),
                icon: const Icon(
                  Icons.featured_play_list,
                  size: 25.0,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(LikedVideos.routeName),
              ),
            ),
          ],
        ),
        const InfluencerProfile(),
      ],
    );

    // Row(
    //   //reverse: true,
    //   children: [

    // const Scaffold(
    //   body: Center(
    //     child: Text('Left'),
    //   ),
    // ),
    // const Scaffold(
    //   body: Center(
    //     child: Text('Right'),
    //   ),
    // )
    //   ],
    // );
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
