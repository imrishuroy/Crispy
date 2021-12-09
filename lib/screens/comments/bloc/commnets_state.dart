part of 'commnets_bloc.dart';

enum CommentsStatus { initial, loading, loaded, submitting, error }

class CommentsState extends Equatable {
  final Video? video;
  final List<Comment?> comments;
  final CommentsStatus status;
  final Failure failure;

  const CommentsState({
    required this.video,
    required this.comments,
    required this.status,
    required this.failure,
  });

  factory CommentsState.initial() {
    return const CommentsState(
      video: null,
      comments: [],
      status: CommentsStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [video, comments, status, failure];

  CommentsState copyWith({
    Video? video,
    List<Comment?>? comments,
    CommentsStatus? status,
    Failure? failure,
  }) {
    return CommentsState(
      video: video ?? this.video,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
