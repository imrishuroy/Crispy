const bool isProduction = bool.fromEnvironment('dart.vm.product');

class Paths {
  // static String get users => isProduction ? 'users' : 'dev-users';
  static String get users => 'users';

  static String get videos => 'videos';

  static String get comments => 'comments';

  static String get influencers => 'influencers';

  static String get likes => 'likes';

  static String get outlets => 'outlets';

  // sub-collections

  static String get likedVideos => 'liked-videos';

  static String get videoComments => 'video-comments';
}
