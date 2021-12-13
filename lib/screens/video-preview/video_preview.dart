import '/screens/home/widgets/main_content.dart';

import '/models/video.dart';

import 'package:flutter/material.dart';

class VideoPreview extends StatelessWidget {
  final Video? video;

  const VideoPreview({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final likedPostsState = context.watch<LikeVideoCubit>().state;
    // final isLiked = likedPostsState.likedVideoIds.contains(video?.videoId);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: ContentView(video: video),
        )

        // Padding(
        //   padding: const EdgeInsets.only(top: 30.0),
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.only(bottom: 10.0),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(8.0),
        //           child: InkWell(
        //               onDoubleTap: () {
        //                 if (isLiked) {
        //                   context
        //                       .read<LikeVideoCubit>()
        //                       .unlikePost(videoId: video?.videoId);
        //                 } else {
        //                   context
        //                       .read<LikeVideoCubit>()
        //                       .likePost(videoId: video?.videoId);
        //                 }
        //               },
        //               child: FullScreenVideo(video: video)),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: 30.0),
        //         child: Row(
        //           mainAxisSize: MainAxisSize.max,
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           children: [
        //             VideoDescription(video: video),
        //             SizedBox(
        //               width: 80.0,
        //               child: Column(mainAxisSize: MainAxisSize.min, children: [
        //                 FavButton(
        //                   isLiked: isLiked,
        //                   videoId: video?.videoId,
        //                   onLike: () {
        //                     if (isLiked) {
        //                       context
        //                           .read<LikeVideoCubit>()
        //                           .unlikePost(videoId: video?.videoId);
        //                     } else {
        //                       context
        //                           .read<LikeVideoCubit>()
        //                           .likePost(videoId: video?.videoId);
        //                     }
        //                     // context
        //                     //     .read<LikeVideoCubit>()
        //                     //     .getLikesCount(videoId: video?.videoId);
        //                   },
        //                 ),
        //                 //const SizedBox(height: 5.0),
        //                 CommentButton(video: video),
        //                 // CommentButton(),
        //                 //  _getSocialAction(icon: TikTokIcons.heart, title: '3.2m'),
        //                 // _getSocialAction(icon: TikTokIcons.chatBubble, title: '16.4k'),
        //                 const SizedBox(height: 140.0)
        //                 //  _getSocialAction(
        //                 //   icon: TikTokIcons.reply, title: 'Share', isShare: true),
        //                 //_getMusicPlayerAction()
        //               ]),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Align(
        //         alignment: Alignment.topRight,
        //         child: IconButton(
        //           padding: const EdgeInsets.only(right: 20.0, top: 7.0),
        //           icon: const Icon(
        //             Icons.featured_play_list,
        //             size: 25.0,
        //           ),
        //           onPressed: () =>
        //               Navigator.of(context).pushNamed(LikedVideos.routeName),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
