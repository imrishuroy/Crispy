part of 'influencer_pageview_cubit.dart';

enum PageViewStatus { scrollable, neverScrollable, error }

class InfluencerPageviewState extends Equatable {
  final Failure failure;
  final PageViewStatus pageViewStatus;

  const InfluencerPageviewState(
      {required this.failure, required this.pageViewStatus});

  factory InfluencerPageviewState.initial() => const InfluencerPageviewState(
        failure: Failure(),
        pageViewStatus: PageViewStatus.scrollable,
      );

  @override
  bool? get stringify => true;

  InfluencerPageviewState copyWith({
    Failure? failure,
    PageViewStatus? pageViewStatus,
  }) {
    return InfluencerPageviewState(
      failure: failure ?? this.failure,
      pageViewStatus: pageViewStatus ?? this.pageViewStatus,
    );
  }

  @override
  List<Object> get props => [failure, pageViewStatus];
}
