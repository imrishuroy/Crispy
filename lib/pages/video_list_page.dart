// import 'dart:math';
// import 'package:crispy/contants/constants.dart';
// import 'package:crispy/models/video_list.dart';
// import 'package:flutter/material.dart';

// import 'video_list_widget.dart';

// class VideoListPage extends StatefulWidget {
//   const VideoListPage({Key? key}) : super(key: key);

//   @override
//   _VideoListPageState createState() => _VideoListPageState();
// }

// class _VideoListPageState extends State<VideoListPage> {
//   final _random = Random();
//   final List<String> _videos = [
//     Constants.bugBuckBunnyVideoUrl,
//     Constants.forBiggerBlazesUrl,
//     Constants.forBiggerJoyridesVideoUrl,
//     Constants.elephantDreamVideoUrl,
//   ];
//   List<VideoListData> dataList = [];
//   var value = 0;

//   @override
//   void initState() {
//     _setupData();
//     super.initState();
//   }

//   void _setupData() {
//     for (int index = 0; index < 10; index++) {
//       var randomVideoUrl = _videos[_random.nextInt(_videos.length)];
//       dataList.add(VideoListData("Video $index", randomVideoUrl));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: dataList.length,
//         itemBuilder: (context, index) {
//           VideoListData videoListData = dataList[index];
//           return VideoListWidget(
//             videoListData: videoListData,
//           );
//         },
//       ),
//     );

//     // Scaffold(
//     //   //  appBar: AppBar(title: Text("Video in list")),
//     //   body: Container(
//     //     color: Colors.grey,
//     //     child: Column(children: [
//     //       // TextButton(
//     //       //   child: Text("Update page state"),
//     //       //   onPressed: () {
//     //       //     setState(() {
//     //       //       value++;
//     //       //     });
//     //       //   },
//     //       // ),
//     //       Expanded(
//     //         child: ListView.builder(
//     //           itemCount: dataList.length,
//     //           itemBuilder: (context, index) {
//     //             VideoListData videoListData = dataList[index];
//     //             return VideoListWidget(
//     //               videoListData: videoListData,
//     //             );
//     //           },
//     //         ),
//     //       )
//     //     ]),
//     //   ),
//     // );
//   }
// }
