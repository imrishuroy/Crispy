part of 'likevideo_cubit.dart';

class LikeVideoState extends Equatable {
  final Set<String> likedVideoIds;
  final Set<String> recentlyLikedVideoIds;
  final int likesCount;

  const LikeVideoState({
    required this.likedVideoIds,
    required this.recentlyLikedVideoIds,
    required this.likesCount,
  });

  factory LikeVideoState.initial() {
    return const LikeVideoState(
      likesCount: 0,
      likedVideoIds: {},
      recentlyLikedVideoIds: {},
    );
  }

  @override
  List<Object> get props => [likedVideoIds, recentlyLikedVideoIds, likesCount];

  LikeVideoState copyWith({
    Set<String>? likedVideoIds,
    Set<String>? recentlyLikedVideoIds,
    int? likesCount,
  }) {
    return LikeVideoState(
      likesCount: likesCount ?? this.likesCount,
      likedVideoIds: likedVideoIds ?? this.likedVideoIds,
      recentlyLikedVideoIds:
          recentlyLikedVideoIds ?? this.recentlyLikedVideoIds,
    );
  }
}
