import 'package:better_player/better_player.dart';
import '/screens/liked-videos/widgets/liked_video_description.dart';
import '/config/contants.dart';
import '/models/video.dart';

import '/screens/home/widgets/comment_button.dart';
import '/screens/home/widgets/cubit/likevideo_cubit.dart';
import '/screens/home/widgets/fav_button.dart';

import '/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LikedVideoContentView extends StatefulWidget {
  final Video? video;

  const LikedVideoContentView({Key? key, required this.video})
      : super(key: key);

  @override
  State<LikedVideoContentView> createState() => _LikedVideoContentViewState();
}

class _LikedVideoContentViewState extends State<LikedVideoContentView> {
  final PageController _pageController = PageController(initialPage: 0);

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
    // _videoController.pause();
    print('Dispose runs ------------');

    //   _videoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _canvas = MediaQuery.of(context).size;
    final likedPostsState = context.watch<LikeVideoCubit>().state;
    final isLiked =
        likedPostsState.likedVideoIds.contains(widget.video?.videoId);
    //  final _pageViewCubit = context.read<PageViewCubit>();

    return PageView(
      onPageChanged: (index) {
        if (index != 1) {
          //_pageViewCubit.makePageViewScrollable();
        } else {
          // _pageViewCubit.makePageViewNeverScrollable();
        }
      },
      controller: _pageController,
      children: [
        // BlocProvider<OutletProfileBloc>(
        //   create: (context) => OutletProfileBloc(
        //     outletId: widget.video?.outlet?.outletId,
        //     outletRepo: context.read<OutletRepository>(),
        //   ),
        //   child: OutletProfile(
        //     outlet: widget.video?.outlet,
        //   ),
        // ),
        Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onDoubleTap: () {
                    if (isLiked) {
                      context
                          .read<LikeVideoCubit>()
                          .unlikePost(videoId: widget.video?.videoId);
                    } else {
                      context
                          .read<LikeVideoCubit>()
                          .likePost(videoId: widget.video?.videoId);
                    }
                  },
                  child: BetterPlayerListVideoPlayer(
                    BetterPlayerDataSource(
                      BetterPlayerDataSourceType.network,
                      widget.video?.videoUrl ?? errorVideo,
                      notificationConfiguration:
                          const BetterPlayerNotificationConfiguration(
                              showNotification: false, title: '', author: ''),
                      bufferingConfiguration:
                          const BetterPlayerBufferingConfiguration(
                              minBufferMs: 2000,
                              maxBufferMs: 10000,
                              bufferForPlaybackMs: 1000,
                              bufferForPlaybackAfterRebufferMs: 2000),
                    ),
                    configuration: const BetterPlayerConfiguration(
                        controlsConfiguration:
                            BetterPlayerControlsConfiguration(
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
                        autoPlay: true,
                        aspectRatio: 0.5,
                        looping: true,
                        handleLifecycle: true,
                        // autoDispose: _pageViewCubit.state.pageViewStatus ==
                        //     PageViewStatus.neverScrollable,
                        autoDispose: true),
                    playFraction: 0.8,
                    betterPlayerListVideoPlayerController: controller,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LikedVideoDescription(video: widget.video),
                  SizedBox(
                    width: 80.0,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      FavButton(
                        isLiked: isLiked,
                        videoId: widget.video?.videoId,
                        onLike: () {
                          if (isLiked) {
                            context
                                .read<LikeVideoCubit>()
                                .unlikePost(videoId: widget.video?.videoId);
                          } else {
                            context
                                .read<LikeVideoCubit>()
                                .likePost(videoId: widget.video?.videoId);
                          }
                        },
                      ),
                      CommentButton(video: widget.video),
                      const SizedBox(height: 140.0)
                    ]),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: IconButton(
            //     padding: const EdgeInsets.only(right: 20.0, top: 7.0),
            //     icon: const Icon(
            //       Icons.featured_play_list,
            //       size: 25.0,
            //     ),
            //     onPressed: () =>
            //         Navigator.of(context).pushNamed(LikedVideos.routeName),
            //   ),
            // ),
          ],
        ),
        //SampleMapView(),
        MapScreen(outlet: widget.video?.outlet),
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
