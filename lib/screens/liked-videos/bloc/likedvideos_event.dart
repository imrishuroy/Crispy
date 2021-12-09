part of 'likedvideos_bloc.dart';

abstract class LikedVideosEvent extends Equatable {
  const LikedVideosEvent();

  @override
  List<Object> get props => [];
}

class LoadLikedVideos extends LikedVideosEvent {
  final List<Video?> videos;

  const LoadLikedVideos({required this.videos});

  @override
  List<Object> get props => [videos];
}
