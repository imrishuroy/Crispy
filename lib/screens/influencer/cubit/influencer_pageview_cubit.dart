import 'package:bloc/bloc.dart';
import '/models/failure.dart';
import 'package:equatable/equatable.dart';

part 'influencer_pageview_state.dart';

class InfluencerPageViewCubit extends Cubit<InfluencerPageViewState> {
  InfluencerPageViewCubit() : super(InfluencerPageViewState.initial());

  void makePageViewScrollable() {
    emit(state.copyWith(pageViewStatus: InfluencerPageViewStatus.initial));
  }

  void makePageViewNeverScrollable() {
    emit(state.copyWith(
        pageViewStatus: InfluencerPageViewStatus.neverScrollable));
  }
}
