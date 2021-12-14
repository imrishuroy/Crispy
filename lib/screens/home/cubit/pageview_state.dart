part of 'pageview_cubit.dart';

enum PageViewStatus { initial, neverScrollable, error }

class PageViewState extends Equatable {
  final Failure failure;
  final PageViewStatus pageViewStatus;

  const PageViewState({
    required this.failure,
    required this.pageViewStatus,
  });

  @override
  List<Object> get props => [failure, pageViewStatus];

  factory PageViewState.initial() => const PageViewState(
      failure: Failure(), pageViewStatus: PageViewStatus.initial);

  @override
  bool? get stringify => true;

  PageViewState copyWith({
    Failure? failure,
    PageViewStatus? pageViewStatus,
  }) {
    return PageViewState(
      failure: failure ?? this.failure,
      pageViewStatus: pageViewStatus ?? this.pageViewStatus,
    );
  }
}
