part of 'commnets_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class CommentsFetchComments extends CommentsEvent {
  final Video video;

  const CommentsFetchComments({required this.video});

  @override
  List<Object> get props => [video];
}

class CommentsUpdateComments extends CommentsEvent {
  final List<Comment?> comments;

  const CommentsUpdateComments({required this.comments});

  @override
  List<Object> get props => [comments];
}

class CommentsPostComment extends CommentsEvent {
  final String content;

  const CommentsPostComment({required this.content});

  @override
  List<Object> get props => [content];
}
