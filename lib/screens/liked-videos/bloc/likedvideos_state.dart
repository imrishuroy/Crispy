part of 'likedvideos_bloc.dart';

enum LikedVideoStatus { initial, loading, succuss, error }

class LikedVideosState extends Equatable {
  final List<Video?> videos;
  final Failure failure;
  final LikedVideoStatus status;

  const LikedVideosState({
    required this.videos,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [videos, failure, status];

  factory LikedVideosState.initial() => const LikedVideosState(
      videos: [], failure: Failure(), status: LikedVideoStatus.initial);

  factory LikedVideosState.loaded(List<Video?> videos) => LikedVideosState(
      videos: videos,
      failure: const Failure(),
      status: LikedVideoStatus.succuss);

  LikedVideosState copyWith({
    List<Video?>? videos,
    Failure? failure,
    LikedVideoStatus? status,
  }) {
    return LikedVideosState(
      videos: videos ?? this.videos,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
