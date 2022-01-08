import 'package:better_player/better_player.dart';
import '/screens/home/cubit/feed_pageview_cubit.dart';
import '/screens/map/map_screen.dart';
import '/config/contants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/widgets/loading_indicator.dart';

import '/screens/home/widgets/cubit/likevideo_cubit.dart';
import '/screens/liked-videos/liked_videos_screen.dart';

import '/models/video.dart';
import '/screens/home/bloc/video_bloc.dart';

import 'package:flutter/material.dart';
import 'comment_button.dart';
import 'fav_button.dart';

import 'video_description.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContentLayout extends StatelessWidget {
  const MainContentLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _videoRepo = context.read<VideoRepository>();
    // final _canvas = MediaQuery.of(context);
    return BlocConsumer<VideoBloc, VideoState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case VideoStatus.succuss:
            final videos = state.videos;

            print('Lenght ${videos.length}');
            return BlocConsumer<FeedPageViewCubit, FeedPageViewState>(
              listener: (context, state) {},
              builder: (context, state) {
                return PageView.builder(
                  // physics: state.pageViewStatus == FeedPageViewStatus.initial
                  //     ? const BouncingScrollPhysics(
                  //         parent: AlwaysScrollableScrollPhysics())
                  //     : const NeverScrollableScrollPhysics(),
                  // NeverScrollableScrollPhysics(),
                  // reverse: true,
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  onPageChanged: (index) {
                    print('Page Index - $index');
                  },
                  itemBuilder: (context, index) {
                    final video = videos[index];

                    return ContentView(video: video);
                  },
                );
              },
            );

          default:
            return const LoadingIndicator();
        }
      },
    );
  }
}

class ContentView extends StatefulWidget {
  final Video? video;

  const ContentView({Key? key, required this.video}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  /// final PageController _pageController = PageController(initialPage: 1);

  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = BetterPlayerListVideoPlayerController();
    // betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
    betterPlayerConfiguration =
        const BetterPlayerConfiguration(autoPlay: false);
  }

  @override
  void dispose() {
    // _videoController.pause();
    print('Dispose runs ------------');

    /// _pageController.dispose();

    //   _videoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _canvas = MediaQuery.of(context).size;
    final likedPostsState = context.watch<LikeVideoCubit>().state;
    final isLiked =
        likedPostsState.likedVideoIds.contains(widget.video?.videoId);
    final _pageViewCubit = context.read<FeedPageViewCubit>();

    return Stack(
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
                configuration: BetterPlayerConfiguration(
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
                  controlsConfiguration:
                      const BetterPlayerControlsConfiguration(
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
                  autoPlay: true,
                  aspectRatio: 0.5,
                  looping: true,
                  handleLifecycle: true,
                  autoDispose: _pageViewCubit.state.pageViewStatus ==
                      FeedPageViewStatus.neverScrollable,
                ),
                playFraction: 0.8,
                betterPlayerListVideoPlayerController: _videoController,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              VideoDescription(video: widget.video),
              SizedBox(
                width: 80.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) =>
                                MapScreen(outlet: widget.video?.outlet)),
                      ),
                      icon: const Icon(
                        Icons.place,
                        size: 33.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
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
                    const SizedBox(height: 25.0),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(LikedVideos.routeName),
                        icon: const Icon(
                          Icons.playlist_play_rounded,
                          size: 27.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0)
                  ],
                ),
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
    );

    // return PageView(
    //   onPageChanged: (index) {
    //     if (index != 1) {
    //       _pageViewCubit.makePageViewScrollable();
    //       _videoController?.pause();
    //     } else {
    //       _pageViewCubit.makePageViewNeverScrollable();
    //       // controller?.pause();
    //     }
    //   },
    //   controller: _pageController,
    //   children: [
    //     BlocProvider<OutletProfileBloc>(
    //       create: (context) => OutletProfileBloc(
    //         outletId: widget.video?.outlet?.outletId,
    //         outletRepo: context.read<OutletRepository>(),
    //       ),
    //       child: OutletProfile(
    //         outlet: widget.video?.outlet,
    //       ),
    //     ),

    //     MapScreen(outlet: widget.video?.outlet),
    //   ],
    // );
  }
}

// class ContentView extends StatefulWidget {
//   final Video? video;

//   const ContentView({Key? key, required this.video}) : super(key: key);

//   @override
//   State<ContentView> createState() => _ContentViewState();
// }

// class _ContentViewState extends State<ContentView> {
//   final PageController _pageController = PageController(initialPage: 1);

//   BetterPlayerConfiguration? betterPlayerConfiguration;
//   BetterPlayerListVideoPlayerController? _videoController;

//   @override
//   void initState() {
//     super.initState();
//     _videoController = BetterPlayerListVideoPlayerController();
//     // betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
//     betterPlayerConfiguration =
//         const BetterPlayerConfiguration(autoPlay: false);
//   }

//   @override
//   void dispose() {
//     // _videoController.pause();
//     print('Dispose runs ------------');
//     _pageController.dispose();

//     //   _videoController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final _canvas = MediaQuery.of(context).size;
//     final likedPostsState = context.watch<LikeVideoCubit>().state;
//     final isLiked =
//         likedPostsState.likedVideoIds.contains(widget.video?.videoId);
//     final _pageViewCubit = context.read<FeedPageViewCubit>();

//     print(
//         'Check false --------------------------- ${_pageViewCubit.state.pageViewStatus == FeedPageViewStatus.neverScrollable}');

//     return PageView(
//       onPageChanged: (index) {
//         if (index != 1) {
//           _pageViewCubit.makePageViewScrollable();
//           _videoController?.pause();
//         } else {
//           _pageViewCubit.makePageViewNeverScrollable();
//           // controller?.pause();
//         }
//       },
//       controller: _pageController,
//       children: [
//         BlocProvider<OutletProfileBloc>(
//           create: (context) => OutletProfileBloc(
//             outletId: widget.video?.outlet?.outletId,
//             outletRepo: context.read<OutletRepository>(),
//           ),
//           child: OutletProfile(
//             outlet: widget.video?.outlet,
//           ),
//         ),
//         Stack(
//           fit: StackFit.expand,
//           children: [
//             Container(
//               padding: const EdgeInsets.only(bottom: 10.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8.0),
//                 child: InkWell(
//                   onDoubleTap: () {
//                     if (isLiked) {
//                       context
//                           .read<LikeVideoCubit>()
//                           .unlikePost(videoId: widget.video?.videoId);
//                     } else {
//                       context
//                           .read<LikeVideoCubit>()
//                           .likePost(videoId: widget.video?.videoId);
//                     }
//                   },
//                   child: BetterPlayerListVideoPlayer(
//                     BetterPlayerDataSource(
//                       BetterPlayerDataSourceType.network,
//                       widget.video?.videoUrl ?? errorVideo,
//                       notificationConfiguration:
//                           const BetterPlayerNotificationConfiguration(
//                               showNotification: false, title: '', author: ''),
//                       bufferingConfiguration:
//                           const BetterPlayerBufferingConfiguration(
//                               minBufferMs: 2000,
//                               maxBufferMs: 10000,
//                               bufferForPlaybackMs: 1000,
//                               bufferForPlaybackAfterRebufferMs: 2000),
//                     ),
//                     configuration: BetterPlayerConfiguration(
//                       controlsConfiguration:
//                           const BetterPlayerControlsConfiguration(
//                         enablePlayPause: false,
//                         showControls: false,
//                         enableProgressBarDrag: false,
//                         enableProgressText: false,
//                         enableProgressBar: false,
//                         enableSkips: false,
//                         enableAudioTracks: false,
//                         loadingWidget: Center(
//                           child: SizedBox(
//                             height: 50.0,
//                             width: 50.0,
//                             child: SpinKitChasingDots(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       autoPlay: true,
//                       aspectRatio: 0.5,
//                       looping: true,
//                       handleLifecycle: true,
//                       autoDispose: _pageViewCubit.state.pageViewStatus ==
//                           FeedPageViewStatus.neverScrollable,
//                     ),
//                     playFraction: 0.8,
//                     betterPlayerListVideoPlayerController: _videoController,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 30.0),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   VideoDescription(video: widget.video),
//                   SizedBox(
//                     width: 80.0,
//                     child: Column(mainAxisSize: MainAxisSize.min, children: [
//                       FavButton(
//                         isLiked: isLiked,
//                         videoId: widget.video?.videoId,
//                         onLike: () {
//                           if (isLiked) {
//                             context
//                                 .read<LikeVideoCubit>()
//                                 .unlikePost(videoId: widget.video?.videoId);
//                           } else {
//                             context
//                                 .read<LikeVideoCubit>()
//                                 .likePost(videoId: widget.video?.videoId);
//                           }
//                         },
//                       ),
//                       CommentButton(video: widget.video),
//                       const SizedBox(height: 140.0)
//                     ]),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 padding: const EdgeInsets.only(right: 20.0, top: 7.0),
//                 icon: const Icon(
//                   Icons.featured_play_list,
//                   size: 25.0,
//                 ),
//                 onPressed: () =>
//                     Navigator.of(context).pushNamed(LikedVideos.routeName),
//               ),
//             ),
//           ],
//         ),
//         MapScreen(outlet: widget.video?.outlet),
//       ],
//     );
//   }
// }
