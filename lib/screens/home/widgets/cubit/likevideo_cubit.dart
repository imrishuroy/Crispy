import 'package:bloc/bloc.dart';
import '/blocs/auth/auth_bloc.dart';

import '/repository/video/video_repository.dart';
import 'package:equatable/equatable.dart';

part 'likevideo_state.dart';

class LikeVideoCubit extends Cubit<LikeVideoState> {
  final VideoRepository _videoRepository;
  final AuthBloc _authBloc;

  LikeVideoCubit({
    required AuthBloc authBloc,
    required VideoRepository videoRepository,
  })  : _videoRepository = videoRepository,
        _authBloc = authBloc,
        super(LikeVideoState.initial());

  void updateLikedPosts({required Set<String> videoIds}) {
    emit(
      state.copyWith(
        likedVideoIds: Set<String>.from(state.likedVideoIds)..addAll(videoIds),
      ),
    );
  }

  void likePost({required String? videoId}) async {
    await _videoRepository.createLike(
      videoId: videoId,
      userId: _authBloc.state.user!.uid,
    );
    if (videoId != null) {
      emit(
        state.copyWith(
          likedVideoIds: Set<String>.from(state.likedVideoIds)..add(videoId),
          recentlyLikedVideoIds: Set<String>.from(state.recentlyLikedVideoIds)
            ..add(videoId),
        ),
      );
    }
  }

  void getLikesCount({required String? videoId}) async {
    final likes = await _videoRepository.getLikesCount(videoId: videoId);
    emit(state.copyWith(likesCount: likes));
  }

  void unlikePost({required String? videoId}) {
    if (videoId != null && _authBloc.state.user?.uid != null) {
      _videoRepository.deleteLike(
        videoId: videoId,
        userId: _authBloc.state.user!.uid,
      );

      emit(
        state.copyWith(
          likedVideoIds: Set<String>.from(state.likedVideoIds)..remove(videoId),
          recentlyLikedVideoIds: Set<String>.from(state.recentlyLikedVideoIds)
            ..remove(videoId),
        ),
      );
    }
  }

  void clearAllLikedPosts() {
    emit(LikeVideoState.initial());
  }
}
