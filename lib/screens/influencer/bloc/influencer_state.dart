part of 'influencer_bloc.dart';

enum InfluencerStatus { initial, loading, succuss, error }

class InfluencerState extends Equatable {
//  final Influencer? influencer;

  final List<Video?> influencerVideos;

  final Failure failure;

  final InfluencerStatus status;

  const InfluencerState({
    //this.influencer,
    required this.influencerVideos,
    required this.failure,
    required this.status,
  });

  factory InfluencerState.initial() => const InfluencerState(
        influencerVideos: [],
        // influencer: null,
        failure: Failure(),
        status: InfluencerStatus.initial,
      );

  factory InfluencerState.loaded({
    // required Influencer influencer,
    required List<Video?> videos,
  }) =>
      InfluencerState(
        //  influencer: influencer,
        influencerVideos: videos,
        failure: const Failure(),
        status: InfluencerStatus.succuss,
      );
  @override
  List<Object?> get props => [failure, status, influencerVideos];
}
