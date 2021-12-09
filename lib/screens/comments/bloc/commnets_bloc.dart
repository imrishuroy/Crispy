import 'dart:async';

import 'package:bloc/bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/appuser.dart';
import '/models/comment.dart';
import '/models/failure.dart';
import '/models/video.dart';
import '/repository/video/video_repository.dart';
import 'package:equatable/equatable.dart';

part 'commnets_event.dart';
part 'commnets_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final VideoRepository _videoRepository;
  final AuthBloc _authBloc;

  StreamSubscription<List<Future<Comment?>>>? _commentsSubscription;

  CommentsBloc({
    required VideoRepository videoRepository,
    required AuthBloc authBloc,
  })  : _videoRepository = videoRepository,
        _authBloc = authBloc,
        super(CommentsState.initial());

  @override
  Future<void> close() {
    _commentsSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is CommentsFetchComments) {
      yield* _mapCommentsFetchCommentsToState(event);
    } else if (event is CommentsUpdateComments) {
      yield* _mapCommentsUpdateCommentsToState(event);
    } else if (event is CommentsPostComment) {
      yield* _mapCommentsPostCommentToState(event);
    }
  }

  Stream<CommentsState> _mapCommentsFetchCommentsToState(
    CommentsFetchComments event,
  ) async* {
    yield state.copyWith(status: CommentsStatus.loading);
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = _videoRepository
          .getPostComments(videoId: event.video.videoId)
          .listen((comments) async {
        final allComments = await Future.wait(comments);
        add(CommentsUpdateComments(comments: allComments));
      });

      yield state.copyWith(video: event.video, status: CommentsStatus.loaded);
    } catch (err) {
      yield state.copyWith(
        status: CommentsStatus.error,
        failure: const Failure(
          message: 'We were unable to load this post\'s comments.',
        ),
      );
    }
  }

  Stream<CommentsState> _mapCommentsUpdateCommentsToState(
    CommentsUpdateComments event,
  ) async* {
    yield state.copyWith(comments: event.comments);
  }

  Stream<CommentsState> _mapCommentsPostCommentToState(
    CommentsPostComment event,
  ) async* {
    yield state.copyWith(status: CommentsStatus.submitting);
    try {
      final author = AppUser.emptyUser.copyWith(uid: _authBloc.state.user?.uid);
      final comment = Comment(
        videoId: state.video?.videoId,
        author: author,
        content: event.content,
        date: DateTime.now(),
      );

      await _videoRepository.createComment(
        //video: state.post!,
        comment: comment,
      );

      yield state.copyWith(status: CommentsStatus.loaded);
    } catch (err) {
      yield state.copyWith(
        status: CommentsStatus.error,
        failure: const Failure(
          message: 'Comment failed to post',
        ),
      );
    }
  }
}
