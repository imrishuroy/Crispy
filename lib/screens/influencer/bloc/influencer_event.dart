part of 'influencer_bloc.dart';

abstract class InfluencerEvent extends Equatable {
  const InfluencerEvent();

  @override
  List<Object> get props => [];
}

class LoadInfluencerProfile extends InfluencerEvent {
  //final Influencer influencer;

  final List<Video?> videos;

  const LoadInfluencerProfile({
    //required this.influencer,
    required this.videos,
  });

  @override
  List<Object> get props => [videos];
}
