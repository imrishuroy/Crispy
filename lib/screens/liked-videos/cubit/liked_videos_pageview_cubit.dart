import 'package:bloc/bloc.dart';
import '/models/failure.dart';
import 'package:equatable/equatable.dart';

part 'liked_videos_pageview_state.dart';

class LikedVideosPageviewCubit extends Cubit<LikedVideosPageviewState> {
  LikedVideosPageviewCubit() : super(LikedVideosPageviewState.initial());

  void makePageViewScrollable() {
    emit(state.copyWith(pageViewStatus: LikedVideosPageViewStatus.scrollable));
  }

  void makePageViewNeverScrollable() {
    emit(state.copyWith(
        pageViewStatus: LikedVideosPageViewStatus.neverScrollable));
  }
}
