import 'package:bloc/bloc.dart';
import 'package:crispy/models/failure.dart';
import 'package:equatable/equatable.dart';

part 'pageview_state.dart';

class PageViewCubit extends Cubit<PageViewState> {
  PageViewCubit() : super(PageViewState.initial());

  void makePageViewScrollable() {
    emit(state.copyWith(pageViewStatus: PageViewStatus.neverScrollable));
  }

  void makePageViewNeverScrollable() {
    emit(state.copyWith(pageViewStatus: PageViewStatus.initial));
  }
}
