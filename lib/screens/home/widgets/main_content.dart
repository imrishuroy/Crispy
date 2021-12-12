import '/repository/outlet/outlet_repository.dart';
import '/screens/home/widgets/cubit/likevideo_cubit.dart';
import '/screens/liked-videos/liked_videos_screen.dart';
import '/screens/outlet/bloc/outletprofile_bloc.dart';
import '/screens/outlet/outlet_profile.dart';

import '/models/video.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/screens/home/bloc/video_bloc.dart';

import '/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'comment_button.dart';
import 'fav_button.dart';
import 'full_screen_video.dart';
import 'video_description.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContentLayout extends StatelessWidget {
  const MainContentLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _videoRepo = context.read<VideoRepository>();
    return BlocConsumer<VideoBloc, VideoState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case VideoStatus.succuss:
            final videos = state.videos;

            print('Lenght ${videos.length}');
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];

                return ContentView(video: video);
              },
            );

          default:
            return const Center(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            );
        }
      },
    );
  }
}

class ContentView extends StatelessWidget {
  final Video? video;

  ContentView({Key? key, required this.video}) : super(key: key);

  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final likedPostsState = context.watch<LikeVideoCubit>().state;
    final isLiked = likedPostsState.likedVideoIds.contains(video?.videoId);
    // final recentlyLiked =
    //     likedPostsState.recentlyLikedVideoIds.contains(video?.videoId);
    return PageView(
      reverse: true,
      controller: _pageController,
      children: [
        const MapScreen(),
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
                            .unlikePost(videoId: video?.videoId);
                      } else {
                        context
                            .read<LikeVideoCubit>()
                            .likePost(videoId: video?.videoId);
                      }
                    },
                    child: FullScreenVideo(video: video)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  VideoDescription(video: video),
                  SizedBox(
                    width: 80.0,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      FavButton(
                        isLiked: isLiked,
                        videoId: video?.videoId,
                        onLike: () {
                          if (isLiked) {
                            context
                                .read<LikeVideoCubit>()
                                .unlikePost(videoId: video?.videoId);
                          } else {
                            context
                                .read<LikeVideoCubit>()
                                .likePost(videoId: video?.videoId);
                          }
                          // context
                          //     .read<LikeVideoCubit>()
                          //     .getLikesCount(videoId: video?.videoId);
                        },
                      ),
                      //const SizedBox(height: 5.0),
                      CommentButton(video: video),
                      // CommentButton(),
                      //  _getSocialAction(icon: TikTokIcons.heart, title: '3.2m'),
                      // _getSocialAction(icon: TikTokIcons.chatBubble, title: '16.4k'),
                      const SizedBox(height: 140.0)
                      //  _getSocialAction(
                      //   icon: TikTokIcons.reply, title: 'Share', isShare: true),
                      //_getMusicPlayerAction()
                    ]),
                  ),
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
        BlocProvider<OutletProfileBloc>(
          create: (context) => OutletProfileBloc(
            outletId: video?.outlet?.outletId,
            outletRepo: context.read<OutletRepository>(),
          ),
          child: OutletProfile(
            outlet: video?.outlet,
          ),
        ),

        // BlocProvider<InfluencerBloc>(
        //   create: (context) => InfluencerBloc(
        //     influencerId: video?.influencer?.influencerId,
        //     influencerRepo: context.read<InfluencerRepository>(),
        //   ),
        //   child: InfluencerProfile(
        //     influencer: video?.influencer,
        //   ),
        // ),
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
