import 'package:bloc/bloc.dart';
import 'package:crispy/models/failure.dart';
import 'package:equatable/equatable.dart';

part 'feed_pageview_state.dart';

class FeedPageViewCubit extends Cubit<FeedPageViewState> {
  FeedPageViewCubit() : super(FeedPageViewState.initial());

  void makePageViewScrollable() {
    emit(state.copyWith(pageViewStatus: FeedPageViewStatus.neverScrollable));
  }

  void makePageViewNeverScrollable() {
    emit(state.copyWith(pageViewStatus: FeedPageViewStatus.initial));
  }
}
