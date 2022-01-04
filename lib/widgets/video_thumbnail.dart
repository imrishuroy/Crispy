import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbNail extends StatefulWidget {
  final String? videoUrl;

  const VideoThumbNail({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoThumbNail> createState() => _VideoThumbNailState();
}

class _VideoThumbNailState extends State<VideoThumbNail> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(widget.videoUrl!)
    //   ..initialize().then((_) {
    //     setState(() {}); //when your thumbnail will show.
    //   });
    image();
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
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
        imageFormat: ImageFormat.WEBP,
        // maxHeight:
        //     70, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 70,
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
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 10.0,
        right: 15.0,
      ),
      child: imageFile != null
          // _controller.value.isInitialized
          ? SizedBox(
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.grey,
              //   ),
              //   borderRadius: BorderRadius.circular(12.0),
              // ),
              width: 100.0,
              height: 206.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              )

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12.0),
              //   child: VideoPlayer(_controller),
              // ),
              )
          : SizedBox(
              height: 50.0,
              width: 50.0,
              child: SpinKitSquareCircle(
                color: Colors.grey.shade300,
                size: 50.0,
              ),
            ),
    );
  }
}
