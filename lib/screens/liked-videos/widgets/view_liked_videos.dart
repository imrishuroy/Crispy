import '/screens/liked-videos/widgets/liked_video_content_view.dart';

import '/models/video.dart';
import 'package:flutter/material.dart';

class ViewLikedVideos extends StatefulWidget {
  final List<Video?> videos;
  final int openIndex;

  const ViewLikedVideos({
    Key? key,
    required this.videos,
    required this.openIndex,
  }) : super(key: key);

  @override
  State<ViewLikedVideos> createState() => _ViewLikedVideosState();
}

class _ViewLikedVideosState extends State<ViewLikedVideos> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.openIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: LikedVideoContentView(video: widget.videos[index]),
          );
        },
      ),
    );
  }
}
