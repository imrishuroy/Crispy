import '/screens/home/home_screen.dart';
import '/models/video.dart';
import '/models/video_list.dart';
import '/screens/home/widgets/comment_button.dart';
import '/screens/home/widgets/cubit/likevideo_cubit.dart';
import '/screens/home/widgets/fav_button.dart';
import '/screens/influencer/widgets/influencer_video_description.dart';
import '/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'outlet_list_widget.dart';

class OutletListVideos extends StatefulWidget {
  final List<Video?> videos;
  final int openIndex;

  const OutletListVideos({
    Key? key,
    required this.videos,
    required this.openIndex,
  }) : super(key: key);

  @override
  _OutletListVideosState createState() => _OutletListVideosState();
}

class _OutletListVideosState extends State<OutletListVideos> {
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
    _pageController = PageController(initialPage: widget.openIndex);
    _setupData();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _setupData() {
    for (int index = 0; index < widget.videos.length; index++) {
      Video? videoUrl = widget.videos[index];
      videoList.add(videoUrl);
      //dataList.add(VideoListData(videoUrl: videoUrl));
    }
  }

  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final likedPostsState = context.watch<LikeVideoCubit>().state;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 2.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          mini: true,
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false),
          child: const Icon(
            Icons.home,
            color: Colors.black87,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      // body: ListView.builder(
      body: PageView.builder(
        controller: _pageController,
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
                      child: OutletListWidget(
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
                            IconButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MapScreen(
                                    outlet: widget.videos[index]?.outlet,
                                    showViewOutlet: false,
                                  ),
                                ),
                              ),
                              icon: const Icon(
                                Icons.place,
                                size: 33.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
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
                            const SizedBox(height: 70.0),
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
