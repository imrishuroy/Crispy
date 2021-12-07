part of 'likevideo_cubit.dart';

class LikeVideoState extends Equatable {
  final Set<String> likedVideoIds;
  final Set<String> recentlyLikedVideoIds;

  const LikeVideoState({
    required this.likedVideoIds,
    required this.recentlyLikedVideoIds,
  });

  factory LikeVideoState.initial() {
    return const LikeVideoState(
      likedVideoIds: {},
      recentlyLikedVideoIds: {},
    );
  }

  @override
  List<Object> get props => [likedVideoIds, recentlyLikedVideoIds];

  LikeVideoState copyWith({
    Set<String>? likedVideoIds,
    Set<String>? recentlyLikedVideoIds,
  }) {
    return LikeVideoState(
      likedVideoIds: likedVideoIds ?? this.likedVideoIds,
      recentlyLikedVideoIds:
          recentlyLikedVideoIds ?? this.recentlyLikedVideoIds,
    );
  }
}
