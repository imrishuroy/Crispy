import '/models/video.dart';
import 'package:flutter/material.dart';

import 'influencer_content_view.dart';

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
        onPageChanged: (index) {
          // setState(() {

          // });
        },
        itemBuilder: (context, index) {
          print('Current Index - $index');
          print('Open Index ${widget.openIndex}');
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: InfluencerContentView(
              video: widget.videos[index],
            ),
          );
        },
      ),
    );
  }
}
