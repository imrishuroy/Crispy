part of 'outletprofile_bloc.dart';

enum OutletProfileStatus { initial, loading, succuss, error }

class OutletProfileState extends Equatable {
  final List<Video?> outletVideos;

  final Failure failure;

  final OutletProfileStatus status;

  const OutletProfileState({
    required this.outletVideos,
    required this.failure,
    required this.status,
  });

  factory OutletProfileState.initial() => const OutletProfileState(
        outletVideos: [],
        // influencer: null,
        failure: Failure(),
        status: OutletProfileStatus.initial,
      );

  factory OutletProfileState.loaded({
    // required Influencer influencer,
    required List<Video?> videos,
  }) =>
      OutletProfileState(
        //  influencer: influencer,
        outletVideos: videos,
        failure: const Failure(),
        status: OutletProfileStatus.succuss,
      );

  @override
  List<Object> get props => [outletVideos, failure, status];
}
