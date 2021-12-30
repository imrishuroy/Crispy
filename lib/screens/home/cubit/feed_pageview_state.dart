part of 'feed_pageview_cubit.dart';

enum FeedPageViewStatus { initial, neverScrollable, error }

class FeedPageViewState extends Equatable {
  final Failure failure;
  final FeedPageViewStatus pageViewStatus;

  const FeedPageViewState({
    required this.failure,
    required this.pageViewStatus,
  });

  @override
  List<Object> get props => [failure, pageViewStatus];

  factory FeedPageViewState.initial() => const FeedPageViewState(
      failure: Failure(), pageViewStatus: FeedPageViewStatus.initial);

  @override
  bool? get stringify => true;

  FeedPageViewState copyWith({
    Failure? failure,
    FeedPageViewStatus? pageViewStatus,
  }) {
    return FeedPageViewState(
      failure: failure ?? this.failure,
      pageViewStatus: pageViewStatus ?? this.pageViewStatus,
    );
  }
}
