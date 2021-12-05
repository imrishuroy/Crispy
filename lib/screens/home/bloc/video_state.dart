part of 'video_bloc.dart';

enum VideoStatus {
  initial,
  loading,
  succuss,
  error,
}

class VideoState extends Equatable {
  final List<Video?> videos;
  final Failure failure;

  final VideoStatus status;

  const VideoState({
    required this.videos,
    required this.failure,
    required this.status,
  });

  factory VideoState.initial() => const VideoState(
      videos: [], failure: Failure(), status: VideoStatus.initial);

  factory VideoState.loaded(List<Video?> videos) => VideoState(
      videos: videos, failure: const Failure(), status: VideoStatus.succuss);

  VideoState copyWith({
    List<Video?>? videos,
    Failure? failure,
    VideoStatus? status,
  }) {
    return VideoState(
      videos: videos ?? this.videos,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [videos, failure, status];
}
