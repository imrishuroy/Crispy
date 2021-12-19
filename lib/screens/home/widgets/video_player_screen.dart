import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoController;
  bool _loading = true;
  @override
  void initState() {
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {

    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

    _videoController = VideoPlayerController.network(widget.videoUrl ?? '')
      ..initialize().then((_) {
        setState(() {
          _loading = false;
          _videoController.play();
          _videoController.setLooping(true);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    // _videoController.pause();
    print('Dispose runs ------------');

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
        : VideoPlayer(_videoController);
  }
}













// import 'package:chewie/chewie.dart';
// import 'package:crispy/config/contants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   final String? videoUrl;

//   const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   //late TargetPlatform? _platform;
//   late VideoPlayerController? _videoPlayerController1;
//   //late VideoPlayerController _videoPlayerController2;
//   late ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   bool _isLoading = true;

//   @override
//   void dispose() {
//     _videoPlayerController1?.dispose();
//     // _videoPlayerController2.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   Future<void> initializePlayer() async {
//     _videoPlayerController1 =
//         VideoPlayerController.network(widget.videoUrl ?? errorVideo);
//     // _videoPlayerController2 =
//     //     VideoPlayerController.network(widget.videoUrl ?? errorVideo);
//     if (_videoPlayerController1 != null) {
//       await Future.wait([
//         _videoPlayerController1!.initialize(),
//         //   _videoPlayerController2.initialize()
//       ]);
//       _createChewieController();
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // @override
//   // void initState() {
//   //   // Create and store the VideoPlayerController. The VideoPlayerController
//   //   // offers several different constructors to play videos from assets, files,
//   //   // or the internet.
//   //   _controller = VideoPlayerController.network(
//   //     widget.videoUrl ?? '',
//   //   );

//   //   // Initialize the controller and store the Future for later use.
//   //   _initializeVideoPlayerFuture = _controller.initialize();

//   //   // Use the controller to loop the video.
//   //   _controller.play();
//   //   _controller.setLooping(true);

//   //   super.initState();
//   // }

//   // videoInit() async {
//   //   try {
//   //     _controller = VideoPlayerController.network(
//   //       widget.videoUrl ?? '',
//   //     );
//   //     return _initializeVideoPlayerFuture = _controller.initialize();
//   //   } catch (error) {
//   //     print('Error in init video ${error.toString()}');
//   //   }
//   // }

//   // Future _videoInit() async {
//   //   try {
//   //     _controller = VideoPlayerController.network(
//   //       widget.videoUrl ?? '',
//   //     )..initialize();
//   //     _controller.setLooping(true);
//   //     // await _controller.initialize();

//   //     // Use the controller to loop the video.

//   //   } catch (e) {
//   //     print('Error in video init ${e.toString()}');
//   //   }
//   // }

//   // Future<void> initializeVideoPlayer() async {
//   //   videoPlayerController =
//   //       VideoPlayerController.network(widget.videoUrl ?? errorVideo);

//   //   if (videoPlayerController != null) {
//   //     await Future.wait([videoPlayerController!.initialize()]);
//   //     chewieController = ChewieController(
//   //       videoPlayerController: videoPlayerController!,
//   //       autoPlay: true,
//   //       looping: true,
//   //     );
//   //   }
//   // }

//   // @override
//   // void dispose() {
//   //   // Ensure disposing of the VideoPlayerController to free up resources.
//   //   // _controller.dispose();
//   //   chewieController?.dispose();

//   //   super.dispose();
//   // }

//   void _createChewieController() {
//     // final subtitles = [
//     //     Subtitle(
//     //       index: 0,
//     //       start: Duration.zero,
//     //       end: const Duration(seconds: 10),
//     //       text: 'Hello from subtitles',
//     //     ),
//     //     Subtitle(
//     //       index: 0,
//     //       start: const Duration(seconds: 10),
//     //       end: const Duration(seconds: 20),
//     //       text: 'Whats up? :)',
//     //     ),
//     //   ];

//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1!,
//       autoPlay: true,
//       looping: true,
//       // fullScreenByDefault: true,

//       showControls: false,
//       showOptions: false,

//       additionalOptions: (context) {
//         return <OptionItem>[
//           OptionItem(
//             onTap: toggleVideo,
//             iconData: Icons.live_tv_sharp,
//             title: 'Toggle Video Src',
//           ),
//         ];
//       },
//       // subtitle: Subtitles(subtitles),
//       // subtitleBuilder: (context, dynamic subtitle) => Container(
//       //   padding: const EdgeInsets.all(10.0),
//       //   child: subtitle is InlineSpan
//       //       ? RichText(
//       //           text: subtitle,
//       //         )
//       //       : Text(
//       //           subtitle.toString(),
//       //           style: const TextStyle(color: Colors.black),
//       //         ),
//       // ),

//       // Try playing around with some of these other options:

//       // showControls: false,
//       // materialProgressColors: ChewieProgressColors(
//       //   playedColor: Colors.red,
//       //   handleColor: Colors.blue,
//       //   backgroundColor: Colors.grey,
//       //   bufferedColor: Colors.lightGreen,
//       // ),
//       // placeholder: Container(
//       //   color: Colors.grey,
//       // ),
//       // autoInitialize: true,
//     );
//   }

//   int currPlayIndex = 0;

//   Future<void> toggleVideo() async {
//     await _videoPlayerController1?.pause();
//     currPlayIndex = currPlayIndex == 0 ? 1 : 0;
//     await initializePlayer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isLoading
//         ? const Center(
//             child: SizedBox(
//               height: 50.0,
//               width: 50.0,
//               child: SpinKitChasingDots(
//                 color: Colors.white,
//               ),
//             ),
//           )
//         : _chewieController != null &&
//                 _chewieController!.videoPlayerController.value.isInitialized
//             ? Chewie(controller: _chewieController!)
//             : const Center(
//                 child: SizedBox(
//                   height: 50.0,
//                   width: 50.0,
//                   child: SpinKitChasingDots(
//                     color: Colors.white,
//                   ),
//                 ),
//               );

//     //  FutureBuilder(
//     //   future: _videoInit(),
//     //   builder: (context, snapshot) {
//     //     if (snapshot.connectionState == ConnectionState.done) {
//     //       // If the VideoPlayerController has finished initialization, use
//     //       // the data it provides to limit the aspect ratio of the video.
//     //       // _controller.play();
//     //       // _controller.setLooping(true);
//     //       _controller.play();

//     //       return VideoPlayer(_controller);
//     //     } else {
//     //       // If the VideoPlayerController is still initializing, show a
//     //       // loading spinner.
//     //       return const Center(
//     //         child: SizedBox(
//     //           height: 50.0,
//     //           width: 50.0,
//     //           child: SpinKitChasingDots(
//     //             color: Colors.white,
//     //           ),
//     //         ),
//     //       );
//     //     }
//     //   },
//     // );
//   }
// }
