import 'dart:math';

import '/models/video_list.dart';
import '/screens/resueable_list-video/reusable_video_list_controller.dart';
import '/screens/resueable_list-video/reusable_video_list_widget.dart';
import 'package:flutter/material.dart';

class ReusableVideoListPage extends StatefulWidget {
  const ReusableVideoListPage({Key? key}) : super(key: key);

  @override
  _ReusableVideoListPageState createState() => _ReusableVideoListPageState();
}

class _ReusableVideoListPageState extends State<ReusableVideoListPage> {
  ReusableVideoListController videoListController =
      ReusableVideoListController();
  final _random = Random();
  final List<String> _videos = [
    // Constants.forBiggerBlazesUrl,
    'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/D%20B%20Mall%20Bhopal%20%23shorts.mp4?alt=media&token=7b9c1454-1c73-45af-9944-1ff9939551c4'
        // Constants.forBiggerJoyridesVideoUrl,
        'https://firebasestorage.googleapis.com/v0/b/crispy-b53c4.appspot.com/o/peoples%20mall.mp4?alt=media&token=6ececfd7-9764-4c79-a184-fbd28674a95a',
  ];
  List<VideoListData> dataList = [];
  var value = 0;
  final ScrollController _scrollController = ScrollController();
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  final bool _canBuildVideo = true;

  @override
  void initState() {
    _setupData();
    super.initState();
  }

  void _setupData() {
    for (int index = 0; index < _videos.length; index++) {
      var randomVideoUrl = _videos[_random.nextInt(_videos.length)];
      dataList.add(VideoListData('Video $index', randomVideoUrl));
    }
  }

  @override
  void dispose() {
    videoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reusable video list')),
      body: Container(
        color: Colors.grey,
        child: Column(children: [
          Expanded(
            child:
                // NotificationListener<ScrollNotification>(
                //   onNotification: (notification) {
                //     final now = DateTime.now();
                //     final timeDiff = now.millisecondsSinceEpoch - lastMilli;
                //     if (notification is ScrollUpdateNotification) {
                //       final pixelsPerMilli = notification.scrollDelta! / timeDiff;
                //       if (pixelsPerMilli.abs() > 1) {
                //         _canBuildVideo = false;
                //       } else {
                //         _canBuildVideo = true;
                //       }
                //       lastMilli = DateTime.now().millisecondsSinceEpoch;
                //     }

                //     if (notification is ScrollEndNotification) {
                //       _canBuildVideo = true;
                //       lastMilli = DateTime.now().millisecondsSinceEpoch;
                //     }

                //     return true;
                //   },
                //   child:

                ListView.builder(
              itemCount: dataList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                VideoListData videoListData = dataList[index];
                print('Video data ------------- ${videoListData.videoUrl}');
                return ReusableVideoListWidget(
                  videoListData: videoListData,
                  videoListController: videoListController,
                  canBuildVideo: _checkCanBuildVideo,
                );
              },
            ),
          ),
          // )
        ]),
      ),
    );
  }

  bool _checkCanBuildVideo() {
    return _canBuildVideo;
  }
}
