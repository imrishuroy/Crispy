import 'package:bloc/bloc.dart';
import '/models/failure.dart';
import 'package:equatable/equatable.dart';

part 'influencer_pageview_state.dart';

class InfluencerPageviewCubit extends Cubit<InfluencerPageviewState> {
  InfluencerPageviewCubit() : super(InfluencerPageviewState.initial());

  void makePageViewScrollable() {
    emit(state.copyWith(pageViewStatus: PageViewStatus.scrollable));
  }

  void makePageViewNeverScrollable() {
    emit(state.copyWith(pageViewStatus: PageViewStatus.neverScrollable));
  }
}
