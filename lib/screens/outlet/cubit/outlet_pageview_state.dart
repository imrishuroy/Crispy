part of 'outlet_pageview_cubit.dart';

enum OutletPageViewStatus { scrollable, neverScrollable, error }

class OutletPageviewState extends Equatable {
  final Failure failure;
  final OutletPageViewStatus pageViewStatus;

  const OutletPageviewState({
    required this.failure,
    required this.pageViewStatus,
  });

  factory OutletPageviewState.initial() => const OutletPageviewState(
        failure: Failure(),
        pageViewStatus: OutletPageViewStatus.scrollable,
      );

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [failure, pageViewStatus];

  OutletPageviewState copyWith({
    Failure? failure,
    OutletPageViewStatus? pageViewStatus,
  }) {
    return OutletPageviewState(
      failure: failure ?? this.failure,
      pageViewStatus: pageViewStatus ?? this.pageViewStatus,
    );
  }
}
