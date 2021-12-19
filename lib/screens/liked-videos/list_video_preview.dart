import 'package:crispy/models/video.dart';
import 'package:crispy/screens/home/widgets/main_content.dart';
import 'package:flutter/material.dart';

class ListVideoPreview extends StatelessWidget {
  final List<Video?> videos;

  const ListVideoPreview({Key? key, required this.videos}) : super(key: key);

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
            child: ContentView(video: videos[index]),
          );
        },
      ),
    );
  }
}
