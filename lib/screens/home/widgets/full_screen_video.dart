import '/models/video.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  final Video? video;

  const FullScreenVideo({Key? key, required this.video}) : super(key: key);

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController _videoController;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {

    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

    _videoController =
        VideoPlayerController.network(widget.video?.videoUrl ?? '')
          ..initialize().then((_) {
            setState(() {
              _loading = false;
              _videoController.play();
              _videoController.setLooping(true);
            });
          });
  }

  @override
  void dispose() {
    _videoController.pause();
    _videoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: SpinKitChasingDots(
                color: Colors.white,
              ),
            ),
          )

        // Center(
        //     child: CircularProgressIndicator(
        //         strokeWidth: 3.0,
        //         valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        //   )
        : InkWell(
            // onDoubleTap: () async {
            //   setState(() {
            //     final userId = context.read<AuthRepository>().userId;
            //     //await FirebaseAuth.instance.signOut();
            //     //print('Current User Id ${.userId}');
            //     print('Video Id ${widget.video?.videoId}');
            //     context
            //         .read<VideoRepository>()
            //         .likeVideo(userId: userId, videoId: widget.video?.videoId);
            //   });
            //},
            child: VideoPlayer(_videoController));
  }
}
