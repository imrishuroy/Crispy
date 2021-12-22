part of 'liked_videos_pageview_cubit.dart';

enum LikedVideosPageViewStatus { scrollable, neverScrollable, error }

class LikedVideosPageviewState extends Equatable {
  final Failure failure;
  final LikedVideosPageViewStatus pageViewStatus;

  const LikedVideosPageviewState({
    required this.failure,
    required this.pageViewStatus,
  });

  factory LikedVideosPageviewState.initial() => const LikedVideosPageviewState(
        failure: Failure(),
        pageViewStatus: LikedVideosPageViewStatus.scrollable,
      );

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [failure, pageViewStatus];

  LikedVideosPageviewState copyWith({
    Failure? failure,
    LikedVideosPageViewStatus? pageViewStatus,
  }) {
    return LikedVideosPageviewState(
      failure: failure ?? this.failure,
      pageViewStatus: pageViewStatus ?? this.pageViewStatus,
    );
  }
}
