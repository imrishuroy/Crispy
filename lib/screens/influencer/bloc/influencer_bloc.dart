import 'package:bloc/bloc.dart';
import '/models/failure.dart';
import '/models/video.dart';
import '/repository/influencer/influencer_repository.dart';
import 'package:equatable/equatable.dart';

part 'influencer_event.dart';
part 'influencer_state.dart';

class InfluencerBloc extends Bloc<InfluencerEvent, InfluencerState> {
  final InfluencerRepository _influencerRepo;

  InfluencerBloc({
    required InfluencerRepository influencerRepo,
    required String? influencerId,
  })  : _influencerRepo = influencerRepo,
        super(InfluencerState.initial()) {
    _influencerRepo
        .streamInfluencerVideos(influencerId: influencerId)
        .listen((event) async {
      add(LoadInfluencerProfile(videos: await Future.wait(event)));
    });
  }

  @override
  Stream<InfluencerState> mapEventToState(InfluencerEvent event) async* {
    if (event is LoadInfluencerProfile) {
      yield* _mapAuthUserChangedToState(event);
    }
  }

  Stream<InfluencerState> _mapAuthUserChangedToState(
      LoadInfluencerProfile event) async* {
    yield InfluencerState.loaded(videos: event.videos);
  }
}
