// import 'package:better_player/better_player.dart';
// import 'package:crispy/screens/home/home_screen.dart';
// import '/config/contants.dart';
// import '/models/video.dart';
// import '/screens/home/widgets/comment_button.dart';
// import '/screens/home/widgets/cubit/likevideo_cubit.dart';
// import '/screens/home/widgets/fav_button.dart';
// import '/screens/map/map_screen.dart';
// import '/screens/outlet/cubit/outlet_pageview_cubit.dart';
// import '/screens/outlet/widgets/outlet_video_description.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ViewOutletVideos extends StatefulWidget {
//   final List<Video?> videos;
//   final int openIndex;

//   const ViewOutletVideos({
//     Key? key,
//     required this.videos,
//     required this.openIndex,
//   }) : super(key: key);

//   @override
//   State<ViewOutletVideos> createState() => _ViewOutletVideosState();
// }

// class _ViewOutletVideosState extends State<ViewOutletVideos> {
//   late PageController _pageController;

//   int get index => widget.openIndex;

//   final PageController _contentpageController = PageController(initialPage: 0);

//   BetterPlayerConfiguration? betterPlayerConfiguration;
//   BetterPlayerListVideoPlayerController? controller;

//   @override
//   void initState() {
//     _pageController = PageController(initialPage: widget.openIndex);
//     controller = BetterPlayerListVideoPlayerController();
//     // betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
//     betterPlayerConfiguration =
//         const BetterPlayerConfiguration(autoPlay: false);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _contentpageController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _pageViewCubit = context.read<OutletPageviewCubit>();
//     final likedPostsState = context.watch<LikeVideoCubit>().state;

//     return WillPopScope(
//       onWillPop: () async {
//         print('Pop happend ----------- ');
//         controller?.pause();

//         // context.read<InfluencerPageviewCubit>().makePageViewScrollable();

//         return true;
//       },
//       child: Scaffold(
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.only(bottom: 10.0, right: 2.0),
//           child: FloatingActionButton(
//             backgroundColor: Colors.white,
//             mini: true,
//             onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
//                 HomeScreen.routeName, (route) => false),
//             child: const Icon(
//               Icons.home,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.black,
//         body: BlocConsumer<OutletPageviewCubit, OutletPageviewState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return PageView.builder(
//               physics: state.pageViewStatus == OutletPageViewStatus.scrollable
//                   ? const BouncingScrollPhysics(
//                       parent: AlwaysScrollableScrollPhysics())
//                   : const NeverScrollableScrollPhysics(),
//               controller: _pageController,
//               scrollDirection: Axis.vertical,
//               itemCount: widget.videos.length,
//               onPageChanged: (index) {
//                 // setState(() {

//                 // });
//               },
//               itemBuilder: (context, index) {
//                 print('Current Index - $index');
//                 print('Open Index ${widget.openIndex}');

//                 final isLiked = likedPostsState.likedVideoIds
//                     .contains(widget.videos[index]?.videoId);
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 30.0),
//                   child: PageView(
//                     onPageChanged: (index) {
//                       if (index == 0) {
//                         //_pageViewCubit.makePageViewScrollable();
//                         _pageViewCubit.makePageViewScrollable();

//                         controller?.pause();
//                       } else {
//                         //_pageViewCubit.makePageViewNeverScrollable();
//                         // controller?.pause();

//                         _pageViewCubit.makePageViewNeverScrollable();
//                       }
//                     },
//                     controller: _contentpageController,
//                     children: [
//                       // BlocProvider<OutletProfileBloc>(
//                       //   create: (context) => OutletProfileBloc(
//                       //     outletId: widget.video?.outlet?.outletId,
//                       //     outletRepo: context.read<OutletRepository>(),
//                       //   ),
//                       //   child: OutletProfile(
//                       //     outlet: widget.video?.outlet,
//                       //   ),
//                       // ),
//                       Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.only(bottom: 10.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8.0),
//                               child: InkWell(
//                                 onDoubleTap: () {
//                                   if (isLiked) {
//                                     context.read<LikeVideoCubit>().unlikePost(
//                                         videoId: widget.videos[index]?.videoId);
//                                   } else {
//                                     context.read<LikeVideoCubit>().likePost(
//                                         videoId: widget.videos[index]?.videoId);
//                                   }
//                                 },
//                                 child: BetterPlayerListVideoPlayer(
//                                   BetterPlayerDataSource(
//                                     BetterPlayerDataSourceType.network,
//                                     widget.videos[index]?.videoUrl ??
//                                         errorVideo,
//                                     notificationConfiguration:
//                                         const BetterPlayerNotificationConfiguration(
//                                             showNotification: false,
//                                             title: '',
//                                             author: ''),
//                                     bufferingConfiguration:
//                                         const BetterPlayerBufferingConfiguration(
//                                             minBufferMs: 2000,
//                                             maxBufferMs: 10000,
//                                             bufferForPlaybackMs: 1000,
//                                             bufferForPlaybackAfterRebufferMs:
//                                                 2000),
//                                   ),
//                                   configuration: BetterPlayerConfiguration(
//                                     controlsConfiguration:
//                                         const BetterPlayerControlsConfiguration(
//                                       enablePlayPause: false,
//                                       showControls: false,
//                                       enableProgressBarDrag: false,
//                                       enableProgressText: false,
//                                       enableProgressBar: false,
//                                       enableSkips: false,
//                                       enableAudioTracks: false,
//                                       loadingWidget: Center(
//                                         child: SizedBox(
//                                           height: 50.0,
//                                           width: 50.0,
//                                           child: SpinKitChasingDots(
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     autoPlay: true,
//                                     aspectRatio: 0.5,
//                                     looping: true,
//                                     handleLifecycle: true,
//                                     // autoDispose: true,
//                                     // autoDispose: false,

//                                     autoDispose: _pageViewCubit
//                                             .state.pageViewStatus ==
//                                         OutletPageViewStatus.neverScrollable,
//                                     // autoDispose: _pageViewCubit.state.pageViewStatus ==
//                                     //     PageViewStatus.neverScrollable,
//                                     // autoDispose: true,
//                                   ),
//                                   // autoDispose: _pageViewCubit.state.pageViewStatus ==
//                                   //     PageViewStatus.neverScrollable),
//                                   playFraction: 0.8,
//                                   betterPlayerListVideoPlayerController:
//                                       controller,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 30.0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 OutletVideoDescription(
//                                     video: widget.videos[index]),
//                                 SizedBox(
//                                   width: 80.0,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       IconButton(
//                                         onPressed: () =>
//                                             Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                             builder: (_) => MapScreen(
//                                               outlet:
//                                                   widget.videos[index]?.outlet,
//                                               showViewOutlet: false,
//                                             ),
//                                           ),
//                                         ),
//                                         icon: const Icon(
//                                           Icons.place,
//                                           size: 33.0,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8.0),
//                                       FavButton(
//                                         isLiked: isLiked,
//                                         videoId: widget.videos[index]?.videoId,
//                                         onLike: () {
//                                           if (isLiked) {
//                                             context
//                                                 .read<LikeVideoCubit>()
//                                                 .unlikePost(
//                                                     videoId: widget
//                                                         .videos[index]
//                                                         ?.videoId);
//                                           } else {
//                                             context
//                                                 .read<LikeVideoCubit>()
//                                                 .likePost(
//                                                     videoId: widget
//                                                         .videos[index]
//                                                         ?.videoId);
//                                           }
//                                         },
//                                       ),
//                                       CommentButton(
//                                           video: widget.videos[index]),
//                                       const SizedBox(height: 70.0)
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

//                       MapScreen(outlet: widget.videos[index]?.outlet),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: PageView.builder(
// //         controller: _pageController,
// //         scrollDirection: Axis.vertical,
// //         itemCount: widget.videos.length,
// //         itemBuilder: (context, index) {
// //           return Padding(
// //             padding: const EdgeInsets.only(top: 30.0),
// //             child: OutletContentView(video: widget.videos[index]),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
