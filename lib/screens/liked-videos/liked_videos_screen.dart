import 'package:crispy/blocs/auth/auth_bloc.dart';
import 'package:crispy/repository/video/video_repository.dart';
import 'package:crispy/screens/liked-videos/bloc/likedvideos_bloc.dart';
import 'package:crispy/widgets/video_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedVideos extends StatefulWidget {
  static const String routeName = '/liked';
  const LikedVideos({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(arguments: routeName),
      builder: (_) => BlocProvider<LikedVideosBloc>(
        create: (context) => LikedVideosBloc(
            authBloc: context.read<AuthBloc>(),
            videoRepository: context.read<VideoRepository>()),
        child: const LikedVideos(),
      ),
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
      body: BlocConsumer<LikedVideosBloc, LikedVideosState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case LikedVideoStatus.succuss:
              final videos = state.videos;

              print('Liked Videos -------$videos');

              return GridView.builder(
                itemCount: videos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: VideoPreview(
                      videoUrl: videos[index]?.videoUrl,
                    ),
                  );
                },
              );

            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
