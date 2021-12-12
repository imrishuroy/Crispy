part of 'outletprofile_bloc.dart';

abstract class OutletProfileEvent extends Equatable {
  const OutletProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadOutletProfile extends OutletProfileEvent {
  //final Influencer influencer;

  final List<Video?> videos;

  const LoadOutletProfile({
    //required this.influencer,
    required this.videos,
  });

  @override
  List<Object> get props => [videos];
}
