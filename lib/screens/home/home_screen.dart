import 'package:flutter/material.dart';

import 'widgets/main_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //   final videoRepo = context.read<VideoRepository>();
      ///  final videos = await videoRepo.getVideos();

      // final video = videos[0];

      // print('My location ${video?.outlet?.location?.latitude}');
      // print('My location ${video?.influencer?.name}');

      // print('Video List ${await videoRepo.getVideos()}');
      //  print('DateTime - ${DateTime.now().millisecondsSinceEpoch}');
      //   },
      // ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          // Top section
          //   const TopBar(),

          const SizedBox(height: 30.0),

          Expanded(child: MainContentLayout()),

          // const BottomToolbar(),
        ],
      ),
    );
  }
}
