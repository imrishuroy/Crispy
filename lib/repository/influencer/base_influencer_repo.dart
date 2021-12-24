import '/models/video.dart';

abstract class BaseInfluencerRepository {
  // Future<Influencer?> getInfluencer({required String? influencerId});

  Stream<List<Future<Video?>>> streamInfluencerVideos(
      {required String? influencerId});
}
