import 'package:crispy/models/video.dart';

import 'package:flutter/material.dart';

import 'outlet_content_view.dart';

class ViewOutletVideos extends StatelessWidget {
  final List<Video?> videos;

  const ViewOutletVideos({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: OutletContentView(video: videos[index]),
          );
        },
      ),
    );
  }
}
