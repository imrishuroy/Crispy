import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crispy/blocs/auth/auth_bloc.dart';
import 'package:crispy/screens/home/widgets/cubit/likevideo_cubit.dart';
import '/models/failure.dart';
import '/models/video.dart';
import '/repository/video/video_repository.dart';
import 'package:equatable/equatable.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;
  final AuthBloc _authBloc;
  final LikeVideoCubit _likedVideoCubit;
  //late StreamSubscription _videoSubscription;

  VideoBloc({
    required VideoRepository videoRepository,
    required AuthBloc authBloc,
    required LikeVideoCubit likeVideoCubit,
  })  : _videoRepository = videoRepository,
        _authBloc = authBloc,
        _likedVideoCubit = likeVideoCubit,
        super(VideoState.initial()) {
    _videoRepository.streamVideos().listen((videos) async {
      add(LoadVideos(videos: await Future.wait(videos)));
    });
    // _videoRepository.streamVideos().listen((event) async {
    //   add(LoadVideos(videos: await Future.wait(event)));
    // });

    /// add(LoadVideos(videos: ))
  }

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is LoadVideos) {
      yield* _mapLoadVideosToState(event);
    }
  }

  Stream<VideoState> _mapLoadVideosToState(LoadVideos event) async* {
    // _videoSubscription.cancel();
    // _videoSubscription = _videoRepository.streamVideos().listen((videos) async {
    //   add(LoadVideos(videos: await Future.wait(videos)));
    // });

    _likedVideoCubit.clearAllLikedPosts();

    final likedVideoIds = await _videoRepository.getLikedVideoIds(
      userId: _authBloc.state.user!.uid,
      videos: event.videos,
    );
    _likedVideoCubit.updateLikedPosts(videoIds: likedVideoIds);

    yield VideoState.loaded(event.videos);
  }

  @override
  Future<void> close() async {
    //await _videoSubscription.cancel();

    return super.close();
  }
}
