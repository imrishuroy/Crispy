import 'package:crispy/models/video.dart';

import 'package:flutter/material.dart';

import 'outlet_content_view.dart';

class ViewOutletVideos extends StatefulWidget {
  final List<Video?> videos;
  final int openIndex;

  const ViewOutletVideos({
    Key? key,
    required this.videos,
    required this.openIndex,
  }) : super(key: key);

  @override
  State<ViewOutletVideos> createState() => _ViewOutletVideosState();
}

class _ViewOutletVideosState extends State<ViewOutletVideos> {
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
            child: OutletContentView(video: widget.videos[index]),
          );
        },
      ),
    );
  }
}
