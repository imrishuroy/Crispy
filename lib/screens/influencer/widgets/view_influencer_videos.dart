import 'package:better_player/better_player.dart';
import 'package:crispy/screens/map/map_screen.dart';
import '/config/contants.dart';
import '/screens/home/widgets/comment_button.dart';
import '/screens/home/widgets/cubit/likevideo_cubit.dart';
import '/screens/home/widgets/fav_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'influencer_video_description.dart';

class ViewInfluencerVideos extends StatefulWidget {
  final List<Video?> videos;
  final int openIndex;

  const ViewInfluencerVideos({
    Key? key,
    required this.videos,
    required this.openIndex,
  }) : super(key: key);

  @override
  State<ViewInfluencerVideos> createState() => _ViewInfluencerVideosState();
}

class _ViewInfluencerVideosState extends State<ViewInfluencerVideos> {
  int get index => widget.openIndex;

  late PageController _pageController;

  final PageController _contentpageController = PageController(initialPage: 0);

  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? _videoController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.openIndex);
    _videoController = BetterPlayerListVideoPlayerController();
    // betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
    betterPlayerConfiguration =
        const BetterPlayerConfiguration(autoPlay: false);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contentpageController.dispose();
    // _videocontroller?.pause();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  final _pageViewCubit = context.read<InfluencerPageViewCubit>();
    final likedPostsState = context.watch<LikeVideoCubit>().state;
    //final _canvas = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        //print('Pop happend ----------- ');

        //_pageViewCubit.makePageViewNeverScrollable();

        _videoController?.pause();
        // _videoController?.setVolume(0.0);
        // context.read<InfluencerPageviewCubit>().makePageViewScrollable();
        print('On will occurs -------- ');

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PageView.builder(
          itemCount: widget.videos.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final isLiked = likedPostsState.likedVideoIds
                .contains(widget.videos[index]?.videoId);
            return Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: PageView(
                onPageChanged: (index) {
                  // if (index == 2) {
                  //   print('Index ------------ 2');
                  //   _pageViewCubit.makePageViewNeverScrollable();
                  // } else {
                  //   _pageViewCubit.makePageViewScrollable();
                  //   _videoController?.pause();

                  //   // controller?.pause();
                  // }
                },

                // onPageChanged: (index) {
                //   if (index == 0) {
                //     print(
                //         'Influencer current page index---------- $index');
                //     //_pageViewCubit.makePageViewScrollable();
                //     _pageViewCubit.makePageViewScrollable();

                //     //controller?.pause();
                //   } else {
                //     //_pageViewCubit.makePageViewNeverScrollable();
                //     _videoController?.pause();
                //     //  controller?.setVolume(0.0);

                //     // print('Influencer current page index1 ---');

                //     _pageViewCubit.makePageViewNeverScrollable();
                //   }
                // },
                controller: _contentpageController,
                children: [
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
                                context.read<LikeVideoCubit>().unlikePost(
                                    videoId: widget.videos[index]?.videoId);
                              } else {
                                context.read<LikeVideoCubit>().likePost(
                                    videoId: widget.videos[index]?.videoId);
                              }
                            },
                            child: BetterPlayerListVideoPlayer(
                              BetterPlayerDataSource(
                                BetterPlayerDataSourceType.network,
                                widget.videos[index]?.videoUrl ?? errorVideo,
                                notificationConfiguration:
                                    const BetterPlayerNotificationConfiguration(
                                        showNotification: false,
                                        title: '',
                                        author: ''),
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
                                autoDispose: false,
                                // autoDispose: true,
                                //                       autoDispose: false //,

                                //                        _pageViewCubit.state.pageViewStatus ==
                                // FeedPageViewStatus.neverScrollable,

                                // autoDispose: _pageViewCubit
                                //         .state.pageViewStatus ==
                                //     InfluencerPageViewStatus.neverScrollable,
                              ),
                              // autoDispose: _pageViewCubit.state.pageViewStatus ==
                              //     PageViewStatus.neverScrollable),
                              playFraction: 0.8,
                              betterPlayerListVideoPlayerController:
                                  _videoController,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MapScreen(
                                  outlet: widget.videos[index]?.outlet),
                            ),
                          ),
                          icon: const Icon(Icons.place),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InfluencerVideoDescription(
                                video: widget.videos[index]),
                            SizedBox(
                              width: 80.0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FavButton(
                                    isLiked: isLiked,
                                    videoId: widget.videos[index]?.videoId,
                                    onLike: () {
                                      if (isLiked) {
                                        context
                                            .read<LikeVideoCubit>()
                                            .unlikePost(
                                                videoId: widget
                                                    .videos[index]?.videoId);
                                      } else {
                                        context.read<LikeVideoCubit>().likePost(
                                            videoId:
                                                widget.videos[index]?.videoId);
                                      }
                                    },
                                  ),
                                  CommentButton(video: widget.videos[index]),
                                  const SizedBox(height: 140.0)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


//**************************************************************** */ */
// import 'package:better_player/better_player.dart';
// import 'package:crispy/models/video_list.dart';
// import 'package:crispy/pages/playlist_page.dart';
// import 'package:crispy/pages/video_list_page.dart';
// import 'package:crispy/pages/video_list_widget.dart';
// import '/config/contants.dart';
// import '/screens/home/widgets/comment_button.dart';
// import '/screens/home/widgets/cubit/likevideo_cubit.dart';
// import '/screens/home/widgets/fav_button.dart';

// import '/screens/map/map_screen.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '/screens/influencer/cubit/influencer_pageview_cubit.dart';

// import '/models/video.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'influencer_video_description.dart';

// class ViewInfluencerVideos extends StatefulWidget {
//   final List<Video?> videos;
//   final int openIndex;

//   const ViewInfluencerVideos({
//     Key? key,
//     required this.videos,
//     required this.openIndex,
//   }) : super(key: key);

//   @override
//   State<ViewInfluencerVideos> createState() => _ViewInfluencerVideosState();
// }

// class _ViewInfluencerVideosState extends State<ViewInfluencerVideos> {
//   int get index => widget.openIndex;

//   late PageController _pageController;

//   final PageController _contentpageController = PageController(initialPage: 0);

//   BetterPlayerConfiguration? betterPlayerConfiguration;
//   BetterPlayerListVideoPlayerController? _videoController;

//   @override
//   void initState() {
//     _pageController = PageController(initialPage: widget.openIndex);
//     _videoController = BetterPlayerListVideoPlayerController();
//     // betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
//     betterPlayerConfiguration =
//         const BetterPlayerConfiguration(autoPlay: false);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _contentpageController.dispose();
//     // _videocontroller?.pause();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _pageViewCubit = context.read<InfluencerPageViewCubit>();
//     final likedPostsState = context.watch<LikeVideoCubit>().state;
//     final _canvas = MediaQuery.of(context).size;

//     return WillPopScope(
//       onWillPop: () async {
//         //print('Pop happend ----------- ');

//         _pageViewCubit.makePageViewNeverScrollable();

//         _videoController?.pause();
//         _videoController?.setVolume(0.0);
//         // context.read<InfluencerPageviewCubit>().makePageViewScrollable();
//         print('On will occurs -------- ');

//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: BlocConsumer<InfluencerPageViewCubit, InfluencerPageViewState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return PageView.builder(
//                 physics:
//                     state.pageViewStatus == InfluencerPageViewStatus.initial
//                         ? const BouncingScrollPhysics(
//                             parent: AlwaysScrollableScrollPhysics())
//                         : const NeverScrollableScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 itemCount: widget.videos.length,
//                 itemBuilder: (context, index) {
//                   final isLiked = likedPostsState.likedVideoIds
//                       .contains(widget.videos[index]?.videoId);
//                   // return Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Container(
//                   //     color: Colors.red,
//                   //     height: 300.0,
//                   //     width: 300,
//                   //   ),
//                   // );
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 30.0),
//                     child: PageView(
//                       onPageChanged: (index) {
//                         if (index == 2) {
//                           print('Index ------------ 2');
//                           _pageViewCubit.makePageViewNeverScrollable();
//                         } else {
//                           _pageViewCubit.makePageViewScrollable();
//                           _videoController?.pause();

//                           // controller?.pause();
//                         }
//                       },

//                       // onPageChanged: (index) {
//                       //   if (index == 0) {
//                       //     print(
//                       //         'Influencer current page index---------- $index');
//                       //     //_pageViewCubit.makePageViewScrollable();
//                       //     _pageViewCubit.makePageViewScrollable();

//                       //     //controller?.pause();
//                       //   } else {
//                       //     //_pageViewCubit.makePageViewNeverScrollable();
//                       //     _videoController?.pause();
//                       //     //  controller?.setVolume(0.0);

//                       //     // print('Influencer current page index1 ---');

//                       //     _pageViewCubit.makePageViewNeverScrollable();
//                       //   }
//                       // },
//                       controller: _contentpageController,
//                       children: [
//                         Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.only(bottom: 10.0),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: InkWell(
//                                   onDoubleTap: () {
//                                     if (isLiked) {
//                                       context.read<LikeVideoCubit>().unlikePost(
//                                           videoId:
//                                               widget.videos[index]?.videoId);
//                                     } else {
//                                       context.read<LikeVideoCubit>().likePost(
//                                           videoId:
//                                               widget.videos[index]?.videoId);
//                                     }
//                                   },
//                                   child: BetterPlayerListVideoPlayer(
//                                     BetterPlayerDataSource(
//                                       BetterPlayerDataSourceType.network,
//                                       widget.videos[index]?.videoUrl ??
//                                           errorVideo,
//                                       notificationConfiguration:
//                                           const BetterPlayerNotificationConfiguration(
//                                               showNotification: false,
//                                               title: '',
//                                               author: ''),
//                                       bufferingConfiguration:
//                                           const BetterPlayerBufferingConfiguration(
//                                               minBufferMs: 2000,
//                                               maxBufferMs: 10000,
//                                               bufferForPlaybackMs: 1000,
//                                               bufferForPlaybackAfterRebufferMs:
//                                                   2000),
//                                     ),
//                                     configuration: BetterPlayerConfiguration(
//                                       controlsConfiguration:
//                                           const BetterPlayerControlsConfiguration(
//                                         enablePlayPause: false,
//                                         showControls: false,
//                                         enableProgressBarDrag: false,
//                                         enableProgressText: false,
//                                         enableProgressBar: false,
//                                         enableSkips: false,
//                                         enableAudioTracks: false,
//                                         loadingWidget: Center(
//                                           child: SizedBox(
//                                             height: 50.0,
//                                             width: 50.0,
//                                             child: SpinKitChasingDots(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       autoPlay: true,
//                                       aspectRatio: 0.5,
//                                       looping: true,
//                                       handleLifecycle: true,
//                                       // autoDispose: true,
//                                       //                       autoDispose: false //,

//                                       //                        _pageViewCubit.state.pageViewStatus ==
//                                       // FeedPageViewStatus.neverScrollable,

//                                       autoDispose:
//                                           _pageViewCubit.state.pageViewStatus ==
//                                               InfluencerPageViewStatus
//                                                   .neverScrollable,
//                                     ),
//                                     // autoDispose: _pageViewCubit.state.pageViewStatus ==
//                                     //     PageViewStatus.neverScrollable),
//                                     playFraction: 0.8,
//                                     betterPlayerListVideoPlayerController:
//                                         _videoController,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 30.0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   InfluencerVideoDescription(
//                                       video: widget.videos[index]),
//                                   SizedBox(
//                                     width: 80.0,
//                                     child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           FavButton(
//                                             isLiked: isLiked,
//                                             videoId:
//                                                 widget.videos[index]?.videoId,
//                                             onLike: () {
//                                               if (isLiked) {
//                                                 context
//                                                     .read<LikeVideoCubit>()
//                                                     .unlikePost(
//                                                         videoId: widget
//                                                             .videos[index]
//                                                             ?.videoId);
//                                               } else {
//                                                 context
//                                                     .read<LikeVideoCubit>()
//                                                     .likePost(
//                                                         videoId: widget
//                                                             .videos[index]
//                                                             ?.videoId);
//                                               }
//                                             },
//                                           ),
//                                           CommentButton(
//                                               video: widget.videos[index]),
//                                           const SizedBox(height: 140.0)
//                                         ]),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         MapScreen(outlet: widget.videos[index]?.outlet),
//                       ],
//                     ),
//                   );
//                 });

//             Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     // physics:
//                     //     state.pageViewStatus == InfluencerPageViewStatus.initial
//                     //         ? const BouncingScrollPhysics(
//                     //             parent: AlwaysScrollableScrollPhysics())
//                     //         : const NeverScrollableScrollPhysics(),
//                     //controller: _pageController,
//                     scrollDirection: Axis.vertical,
//                     itemCount: widget.videos.length,
//                     // onPageChanged: (index) {
//                     //   // setState(() {

//                     //   // });
//                     // },
//                     itemBuilder: (context, index) {
//                       print('Current Index - $index');
//                       print('Open Index ${widget.openIndex}');

//                       final isLiked = likedPostsState.likedVideoIds
//                           .contains(widget.videos[index]?.videoId);
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 30.0),
//                         child: PageView(
//                           onPageChanged: (index) {
//                             if (index == 0) {
//                               print(
//                                   'Influencer current page index---------- $index');
//                               //_pageViewCubit.makePageViewScrollable();
//                               _pageViewCubit.makePageViewScrollable();

//                               //controller?.pause();
//                             } else {
//                               //_pageViewCubit.makePageViewNeverScrollable();
//                               _videoController?.pause();
//                               //  controller?.setVolume(0.0);

//                               // print('Influencer current page index1 ---');

//                               _pageViewCubit.makePageViewNeverScrollable();
//                             }
//                           },
//                           controller: _contentpageController,
//                           children: [
//                             // BlocProvider<OutletProfileBloc>(
//                             //   create: (context) => OutletProfileBloc(
//                             //     outletId: widget.video?.outlet?.outletId,
//                             //     outletRepo: context.read<OutletRepository>(),
//                             //   ),
//                             //   child: OutletProfile(
//                             //     outlet: widget.video?.outlet,
//                             //   ),
//                             // ),
//                             ///    const PlaylistPage(),
//                             // const VideoListPage(),

//                             /////////////////////////////////////////////////
//                             Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.only(bottom: 10.0),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     child: InkWell(
//                                       onDoubleTap: () {
//                                         if (isLiked) {
//                                           context
//                                               .read<LikeVideoCubit>()
//                                               .unlikePost(
//                                                   videoId: widget
//                                                       .videos[index]?.videoId);
//                                         } else {
//                                           context
//                                               .read<LikeVideoCubit>()
//                                               .likePost(
//                                                   videoId: widget
//                                                       .videos[index]?.videoId);
//                                         }
//                                       },
//                                       child: VideoListWidget(
//                                         videoListData: VideoListData(
//                                             '',
//                                             widget.videos[index]?.videoUrl ??
//                                                 errorVideo),
//                                       ),

//                                       // BetterPlayerListVideoPlayer(
//                                       //   BetterPlayerDataSource(
//                                       //     BetterPlayerDataSourceType.network,
//                                       //     widget.videos[index]?.videoUrl ??
//                                       //         errorVideo,
//                                       //     notificationConfiguration:
//                                       //         const BetterPlayerNotificationConfiguration(
//                                       //             showNotification: false,
//                                       //             title: '',
//                                       //             author: ''),
//                                       //     bufferingConfiguration:
//                                       //         const BetterPlayerBufferingConfiguration(
//                                       //             minBufferMs: 2000,
//                                       //             maxBufferMs: 10000,
//                                       //             bufferForPlaybackMs: 1000,
//                                       //             bufferForPlaybackAfterRebufferMs:
//                                       //                 2000),
//                                       //   ),
//                                       //   configuration:
//                                       //       const BetterPlayerConfiguration(
//                                       //           controlsConfiguration:
//                                       //               BetterPlayerControlsConfiguration(
//                                       //             enablePlayPause: false,
//                                       //             showControls: false,
//                                       //             enableProgressBarDrag: false,
//                                       //             enableProgressText: false,
//                                       //             enableProgressBar: false,
//                                       //             enableSkips: false,
//                                       //             enableAudioTracks: false,
//                                       //             loadingWidget: Center(
//                                       //               child: SizedBox(
//                                       //                 height: 50.0,
//                                       //                 width: 50.0,
//                                       //                 child: SpinKitChasingDots(
//                                       //                   color: Colors.white,
//                                       //                 ),
//                                       //               ),
//                                       //             ),
//                                       //           ),
//                                       //           autoPlay: true,
//                                       //           aspectRatio: 0.5,
//                                       //           looping: true,
//                                       //           handleLifecycle: true,
//                                       //           // autoDispose: true,
//                                       //           autoDispose: false //,

//                                       //           // autoDispose:
//                                       //           //     _pageViewCubit.state.pageViewStatus ==
//                                       //           //         InfluencerPageViewStatus
//                                       //           //             .neverScrollable,
//                                       //           ),
//                                       // autoDispose: _pageViewCubit.state.pageViewStatus ==
//                                       //     PageViewStatus.neverScrollable),
//                                       // playFraction: 0.8,
//                                       // betterPlayerListVideoPlayerController:
//                                       //     _videocontroller,
//                                       //),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 30.0),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       InfluencerVideoDescription(
//                                           video: widget.videos[index]),
//                                       SizedBox(
//                                         width: 80.0,
//                                         child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               FavButton(
//                                                 isLiked: isLiked,
//                                                 videoId: widget
//                                                     .videos[index]?.videoId,
//                                                 onLike: () {
//                                                   if (isLiked) {
//                                                     context
//                                                         .read<LikeVideoCubit>()
//                                                         .unlikePost(
//                                                             videoId: widget
//                                                                 .videos[index]
//                                                                 ?.videoId);
//                                                   } else {
//                                                     context
//                                                         .read<LikeVideoCubit>()
//                                                         .likePost(
//                                                             videoId: widget
//                                                                 .videos[index]
//                                                                 ?.videoId);
//                                                   }
//                                                 },
//                                               ),
//                                               CommentButton(
//                                                   video: widget.videos[index]),
//                                               const SizedBox(height: 140.0)
//                                             ]),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),

// /////////////////////////////////////////////////////////////////////////////////

//                             // Stack(
//                             //   fit: StackFit.expand,
//                             //   children: [
//                             //     Container(
//                             //       padding: const EdgeInsets.only(bottom: 10.0),
//                             //       child: ClipRRect(
//                             //         borderRadius: BorderRadius.circular(8.0),
//                             //         child: InkWell(
//                             //           onDoubleTap: () {
//                             //             if (isLiked) {
//                             //               context.read<LikeVideoCubit>().unlikePost(
//                             //                   videoId: widget.videos[index]?.videoId);
//                             //             } else {
//                             //               context.read<LikeVideoCubit>().likePost(
//                             //                   videoId: widget.videos[index]?.videoId);
//                             //             }
//                             //           },
//                             //           child: BetterPlayerListVideoPlayer(
//                             //             BetterPlayerDataSource(
//                             //               BetterPlayerDataSourceType.network,
//                             //               widget.videos[index]?.videoUrl ??
//                             //                   errorVideo,
//                             //               notificationConfiguration:
//                             //                   const BetterPlayerNotificationConfiguration(
//                             //                       showNotification: false,
//                             //                       title: '',
//                             //                       author: ''),
//                             //               bufferingConfiguration:
//                             //                   const BetterPlayerBufferingConfiguration(
//                             //                       minBufferMs: 2000,
//                             //                       maxBufferMs: 10000,
//                             //                       bufferForPlaybackMs: 1000,
//                             //                       bufferForPlaybackAfterRebufferMs:
//                             //                           2000),
//                             //             ),
//                             //             configuration:
//                             //                 const BetterPlayerConfiguration(
//                             //                     controlsConfiguration:
//                             //                         BetterPlayerControlsConfiguration(
//                             //                       enablePlayPause: false,
//                             //                       showControls: false,
//                             //                       enableProgressBarDrag: false,
//                             //                       enableProgressText: false,
//                             //                       enableProgressBar: false,
//                             //                       enableSkips: false,
//                             //                       enableAudioTracks: false,
//                             //                       loadingWidget: Center(
//                             //                         child: SizedBox(
//                             //                           height: 50.0,
//                             //                           width: 50.0,
//                             //                           child: SpinKitChasingDots(
//                             //                             color: Colors.white,
//                             //                           ),
//                             //                         ),
//                             //                       ),
//                             //                     ),
//                             //                     autoPlay: true,
//                             //                     aspectRatio: 0.5,
//                             //                     looping: true,
//                             //                     handleLifecycle: true,
//                             //                     // autoDispose: true,
//                             //                     autoDispose: false //,

//                             //                     // autoDispose:
//                             //                     //     _pageViewCubit.state.pageViewStatus ==
//                             //                     //         InfluencerPageViewStatus
//                             //                     //             .neverScrollable,
//                             //                     ),
//                             //             // autoDispose: _pageViewCubit.state.pageViewStatus ==
//                             //             //     PageViewStatus.neverScrollable),
//                             //             playFraction: 0.8,
//                             //             betterPlayerListVideoPlayerController:
//                             //                 _videocontroller,
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     ),
//                             //     Padding(
//                             //       padding: const EdgeInsets.only(bottom: 30.0),
//                             //       child: Row(
//                             //         mainAxisSize: MainAxisSize.max,
//                             //         crossAxisAlignment: CrossAxisAlignment.end,
//                             //         children: [
//                             //           InfluencerVideoDescription(
//                             //               video: widget.videos[index]),
//                             //           SizedBox(
//                             //             width: 80.0,
//                             //             child: Column(
//                             //                 mainAxisSize: MainAxisSize.min,
//                             //                 children: [
//                             //                   FavButton(
//                             //                     isLiked: isLiked,
//                             //                     videoId:
//                             //                         widget.videos[index]?.videoId,
//                             //                     onLike: () {
//                             //                       if (isLiked) {
//                             //                         context
//                             //                             .read<LikeVideoCubit>()
//                             //                             .unlikePost(
//                             //                                 videoId: widget
//                             //                                     .videos[index]
//                             //                                     ?.videoId);
//                             //                       } else {
//                             //                         context
//                             //                             .read<LikeVideoCubit>()
//                             //                             .likePost(
//                             //                                 videoId: widget
//                             //                                     .videos[index]
//                             //                                     ?.videoId);
//                             //                       }
//                             //                     },
//                             //                   ),
//                             //                   CommentButton(
//                             //                       video: widget.videos[index]),
//                             //                   const SizedBox(height: 140.0)
//                             //                 ]),
//                             //           ),
//                             //         ],
//                             //       ),
//                             //     ),
//                             //   ],
//                             // ),

//                             MapScreen(outlet: widget.videos[index]?.outlet),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
