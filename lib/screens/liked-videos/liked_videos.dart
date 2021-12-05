import 'package:flutter/material.dart';

class LikedVideos extends StatefulWidget {
  static const String routeName = '/liked';
  const LikedVideos({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(arguments: routeName),
      builder: (_) => const LikedVideos(),
    );
  }

  @override
  _LikedVideosState createState() => _LikedVideosState();
}

class _LikedVideosState extends State<LikedVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Liked Videos'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.red,
              height: 270.0,
              width: 100.0,
            ),
          );
        },
      ),
    );
  }
}
