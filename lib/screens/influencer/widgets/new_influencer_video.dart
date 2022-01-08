// import 'package:better_player/better_player.dart';
// import 'package:crispy/config/contants.dart';
// import 'package:crispy/models/video.dart';
// import 'package:crispy/screens/home/widgets/comment_button.dart';
// import 'package:crispy/screens/home/widgets/cubit/likevideo_cubit.dart';
// import 'package:crispy/screens/home/widgets/fav_button.dart';
// import 'package:crispy/screens/map/map_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'influencer_video_description.dart';

// class NewInfluencerVideo extends StatefulWidget {
//   final List<Video?> videos;
//   final int openIndex;

//   const NewInfluencerVideo({
//     Key? key,
//     required this.videos,
//     required this.openIndex,
//   }) : super(key: key);

//   @override
//   State<NewInfluencerVideo> createState() => _NewInfluencerVideoState();
// }

// class _NewInfluencerVideoState extends State<NewInfluencerVideo> {
//   late PageController? _pageController;

//   @override
//   void initState() {
//     _pageController = PageController(initialPage: widget.openIndex);
//     // _betterPlayerController =
//     //     BetterPlayerController(BetterPlayerConfiguration());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TO implement dispose
//     super.dispose();
//   }

//   //late BetterPlayerController _betterPlayerController;

//   @override
//   Widget build(BuildContext context) {
//     final _likedPostsState = context.watch<LikeVideoCubit>().state;
//     return Scaffold(
//       body: PageView.builder(
//         scrollDirection: Axis.vertical,
//         controller: _pageController,
//         itemCount: widget.videos.length,
//         itemBuilder: (context, index) {
//           final video = widget.videos[index];
//           final isLiked = _likedPostsState.likedVideoIds
//               .contains(widget.videos[index]?.videoId);
//           return Padding(
//             padding: const EdgeInsets.only(top: 30.0),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(bottom: 10.0),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: InkWell(
//                       onDoubleTap: () {
//                         if (isLiked) {
//                           context.read<LikeVideoCubit>().unlikePost(
//                               videoId: widget.videos[index]?.videoId);
//                         } else {
//                           context
//                               .read<LikeVideoCubit>()
//                               .likePost(videoId: widget.videos[index]?.videoId);
//                         }
//                       },
//                       child: BetterPlayer.network(
//                         video?.videoUrl ?? errorVideo,
//                         betterPlayerConfiguration:
//                             const BetterPlayerConfiguration(
//                           aspectRatio: 0.5,
//                           autoPlay: true,
//                           autoDispose: false,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: IconButton(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0,
//                       vertical: 20.0,
//                     ),
//                     onPressed: () => Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             MapScreen(outlet: widget.videos[index]?.outlet),
//                       ),
//                     ),
//                     icon: const Icon(Icons.place),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 30.0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       InfluencerVideoDescription(video: widget.videos[index]),
//                       SizedBox(
//                         width: 80.0,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             FavButton(
//                               isLiked: isLiked,
//                               videoId: widget.videos[index]?.videoId,
//                               onLike: () {
//                                 if (isLiked) {
//                                   context.read<LikeVideoCubit>().unlikePost(
//                                       videoId: widget.videos[index]?.videoId);
//                                 } else {
//                                   context.read<LikeVideoCubit>().likePost(
//                                       videoId: widget.videos[index]?.videoId);
//                                 }
//                               },
//                             ),
//                             CommentButton(video: widget.videos[index]),
//                             const SizedBox(height: 140.0)
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
