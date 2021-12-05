import 'package:bloc/bloc.dart';
import '/models/failure.dart';
import '/models/video.dart';
import '/repository/video/video_repository.dart';
import 'package:equatable/equatable.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _authRepository;

  VideoBloc({required VideoRepository videoRepository})
      : _authRepository = videoRepository,
        super(VideoState.initial()) {
    _authRepository.streamVideos().listen((event) async {
      add(LoadVideos(videos: await Future.wait(event)));
    });

    /// add(LoadVideos(videos: ))
  }

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is LoadVideos) {
      yield* _mapAuthUserChangedToState(event);
    }
  }

  Stream<VideoState> _mapAuthUserChangedToState(LoadVideos event) async* {
    yield VideoState.loaded(event.videos);
  }
}
