import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPreview extends StatefulWidget {
  final String? videoUrl;

  const VideoPreview({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl!)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // @override
  // void initState() {
  //   image();
  //   super.initState();
  // }

  Future<void> image() async {
    if (widget.videoUrl != null) {
      final fileName = await VideoThumbnail.thumbnailFile(
        video: widget.videoUrl!,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight:
            64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 100,
      );

      if (fileName != null) {
        setState(() {
          imageFile = File(fileName);
        });
      }

      print('FIle name $fileName');
    }
  }

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _controller.value.isInitialized
          ? SizedBox(
              width: 100.0,
              height: 206.0,
              child: VideoPlayer(_controller),
            )
          : const CircularProgressIndicator(),
    );
  }
}
