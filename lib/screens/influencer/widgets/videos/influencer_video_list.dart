import 'package:crispy/models/video.dart';
import 'package:crispy/models/video_list.dart';
import 'package:crispy/screens/home/widgets/comment_button.dart';
import 'package:crispy/screens/home/widgets/cubit/likevideo_cubit.dart';
import 'package:crispy/screens/home/widgets/fav_button.dart';
import 'package:crispy/screens/influencer/widgets/influencer_video_description.dart';
import 'package:crispy/screens/map/map_screen.dart';
import 'package:flutter/material.dart';

import 'influencer_video_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfluencerListVideos extends StatefulWidget {
  final List<Video?> videos;

  const InfluencerListVideos({Key? key, required this.videos})
      : super(key: key);

  @override
  _InfluencerListVideosState createState() => _InfluencerListVideosState();
}

class _InfluencerListVideosState extends State<InfluencerListVideos> {
  // final _random = Random();
  // final List<String> _videos = [
  //   Constants.bugBuckBunnyVideoUrl,
  //   Constants.forBiggerBlazesUrl,
  //   Constants.forBiggerJoyridesVideoUrl,
  //   Constants.elephantDreamVideoUrl,
  // ];
  //List<String?> videoList = [];
  // var value = 0;
  List<Video?> videoList = [];

  @override
  void initState() {
    _setupData();
    super.initState();
  }

  void _setupData() {
    for (int index = 0; index < widget.videos.length; index++) {
      Video? videoUrl = widget.videos[index];
      videoList.add(videoUrl);
      //dataList.add(VideoListData(videoUrl: videoUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final likedPostsState = context.watch<LikeVideoCubit>().state;
    return Scaffold(
      backgroundColor: Colors.black,
      // body: ListView.builder(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final isLiked = likedPostsState.likedVideoIds
              .contains(widget.videos[index]?.videoId);
          VideoListData videoListData =
              VideoListData(videoUrl: videoList[index]?.videoUrl);
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: GestureDetector(
                      onDoubleTap: () {
                        if (isLiked) {
                          context.read<LikeVideoCubit>().unlikePost(
                              videoId: widget.videos[index]?.videoId);
                        } else {
                          context
                              .read<LikeVideoCubit>()
                              .likePost(videoId: widget.videos[index]?.videoId);
                        }
                      },
                      child: InfluencerListVideoWidget(
                        videoListData: videoListData,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            MapScreen(outlet: widget.videos[index]?.outlet),
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
                      InfluencerVideoDescription(video: widget.videos[index]),
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
                                  context.read<LikeVideoCubit>().unlikePost(
                                      videoId: widget.videos[index]?.videoId);
                                } else {
                                  context.read<LikeVideoCubit>().likePost(
                                      videoId: widget.videos[index]?.videoId);
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
                ),
              ],
            ),
          );
        },
      ),
    );

    // Scaffold(
    //   //  appBar: AppBar(title: Text("Video in list")),
    //   body: Container(
    //     color: Colors.grey,
    //     child: Column(children: [
    //       // TextButton(
    //       //   child: Text("Update page state"),
    //       //   onPressed: () {
    //       //     setState(() {
    //       //       value++;
    //       //     });
    //       //   },
    //       // ),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: dataList.length,
    //           itemBuilder: (context, index) {
    //             VideoListData videoListData = dataList[index];
    //             return VideoListWidget(
    //               videoListData: videoListData,
    //             );
    //           },
    //         ),
    //       )
    //     ]),
    //   ),
    // );
  }
}
