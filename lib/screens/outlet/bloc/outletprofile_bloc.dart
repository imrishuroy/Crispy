import 'package:bloc/bloc.dart';
import '/models/failure.dart';
import '/models/video.dart';
import '/repository/outlet/outlet_repository.dart';
import 'package:equatable/equatable.dart';

part 'outletprofile_event.dart';
part 'outletprofile_state.dart';

class OutletProfileBloc extends Bloc<OutletProfileEvent, OutletProfileState> {
  final OutletRepository _outletRepo;

  OutletProfileBloc({
    required OutletRepository outletRepo,
    required String? outletId,
  })  : _outletRepo = outletRepo,
        super(OutletProfileState.initial()) {
    _outletRepo.streamOutletVideos(outletId: outletId).listen((event) async {
      add(LoadOutletProfile(videos: await Future.wait(event)));
    });
  }

  @override
  Stream<OutletProfileState> mapEventToState(OutletProfileEvent event) async* {
    if (event is LoadOutletProfile) {
      yield* _mapLoadOutletProfileToState(event);
    }
  }

  Stream<OutletProfileState> _mapLoadOutletProfileToState(
      LoadOutletProfile event) async* {
    yield OutletProfileState.loaded(videos: event.videos);
  }
}
