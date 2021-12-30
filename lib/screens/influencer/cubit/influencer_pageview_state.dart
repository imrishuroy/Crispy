part of 'influencer_pageview_cubit.dart';

enum InfluencerPageViewStatus { initial, neverScrollable, error }

class InfluencerPageViewState extends Equatable {
  final Failure failure;
  final InfluencerPageViewStatus pageViewStatus;

  const InfluencerPageViewState({
    required this.failure,
    required this.pageViewStatus,
  });

  factory InfluencerPageViewState.initial() => const InfluencerPageViewState(
        failure: Failure(),
        pageViewStatus: InfluencerPageViewStatus.initial,
      );

  @override
  bool? get stringify => true;

  InfluencerPageViewState copyWith({
    Failure? failure,
    InfluencerPageViewStatus? pageViewStatus,
  }) {
    return InfluencerPageViewState(
      failure: failure ?? this.failure,
      pageViewStatus: pageViewStatus ?? this.pageViewStatus,
    );
  }

  @override
  List<Object> get props => [failure, pageViewStatus];
}
