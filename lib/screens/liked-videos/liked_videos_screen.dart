import '/config/shared_prefs.dart';
import '/repository/auth/auth_repository.dart';
import '/screens/liked-videos/cubit/liked_videos_pageview_cubit.dart';
import '/screens/liked-videos/widgets/view_liked_videos.dart';
import '/widgets/video_thumbnail.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repository/video/video_repository.dart';
import '/screens/liked-videos/bloc/likedvideos_bloc.dart';
import '/widgets/loading_indicator.dart';
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
  Future<void> _signOutUser() async {
    try {
      var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('SignOut'),
            content: const Text('Do you want to sign out ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
        },
      );

      final bool logout = await result ?? false;
      if (logout) {
        await SharedPrefs().deleteEverything();
        final _authRepo = context.read<AuthRepository>();
        await _authRepo.signOut();
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: _signOutUser,
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
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
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              BlocProvider<LikedVideosPageviewCubit>(
                            create: (context) => LikedVideosPageviewCubit(),
                            child: ViewLikedVideos(
                              // VideoPreview(
                              videos: videos, openIndex: index,
                            ),
                          ),
                        ),
                      ),
                      // child: Scaffold(
                      //   body: PageView.builder(
                      //     itemCount: videos.length,
                      //     itemBuilder: (context, index) {
                      //       return ContentView(video: videos[index]);
                      //     },
                      //   ),
                      // ),
                      child: VideoThumbNail(
                        videoUrl: videos[index]?.videoUrl,
                      ),
                    ),
                  );
                },
              );

            default:
              return const LoadingIndicator();
          }
        },
      ),
    );
  }
}
