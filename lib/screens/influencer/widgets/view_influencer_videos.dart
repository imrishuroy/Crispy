import '/models/video.dart';
import 'package:flutter/material.dart';

import 'influencer_content_view.dart';

class ViewInfluencerVideos extends StatelessWidget {
  final List<Video?> videos;

  const ViewInfluencerVideos({Key? key, required this.videos})
      : super(key: key);

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
            child: InfluencerContentView(video: videos[index]),
          );
        },
      ),
    );
  }
}
