import 'package:bloc/bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';
import '/models/video.dart';

import '/repository/video/video_repository.dart';
import 'package:equatable/equatable.dart';

part 'likedvideos_event.dart';
part 'likedvideos_state.dart';

class LikedVideosBloc extends Bloc<LikedVideosEvent, LikedVideosState> {
  final VideoRepository _videoRepository;
  final AuthBloc _authBloc;

  LikedVideosBloc({
    required VideoRepository videoRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _videoRepository = videoRepository,
        super(LikedVideosState.initial()) {
    _videoRepository
        .streamUserLikedVideos(userId: _authBloc.state.user?.uid)
        .listen((videos) async =>
            add(LoadLikedVideos(videos: await Future.wait(videos))));
  }

  @override
  Stream<LikedVideosState> mapEventToState(LikedVideosEvent event) async* {
    if (event is LoadLikedVideos) {
      yield* _mapLoadVideosToState(event);
    }
  }

  Stream<LikedVideosState> _mapLoadVideosToState(LoadLikedVideos event) async* {
    yield LikedVideosState.loaded(event.videos);
  }
}
