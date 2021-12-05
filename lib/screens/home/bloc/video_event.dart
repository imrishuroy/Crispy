part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideos extends VideoEvent {
  final List<Video?> videos;

  const LoadVideos({required this.videos});

  @override
  List<Object> get props => [videos];
}
