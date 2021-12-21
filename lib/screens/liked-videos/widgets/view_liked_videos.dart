import '/screens/liked-videos/widgets/liked_video_content_view.dart';

import '/models/video.dart';
import 'package:flutter/material.dart';

class ViewLikedVideos extends StatelessWidget {
  final List<Video?> videos;

  const ViewLikedVideos({Key? key, required this.videos}) : super(key: key);

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
            child: LikedVideoContentView(video: videos[index]),
          );
        },
      ),
    );
  }
}
