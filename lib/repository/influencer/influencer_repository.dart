import 'package:cloud_firestore/cloud_firestore.dart';
import '/contants/paths.dart';
import '/models/influencer.dart';
import '/models/video.dart';
import '/repository/influencer/base_influencer_repo.dart';

class InfluencerRepository extends BaseInfluencerRepository {
  final _influencerRef = FirebaseFirestore.instance.collection('influencers');

  @override
  Future<Influencer?> getInfluencer({required String? influencerId}) async {
    try {
      final snapshot = await _influencerRef
          .doc(influencerId)
          .withConverter<Influencer>(
              fromFirestore: (snapshot, _) =>
                  Influencer.fromMap(snapshot.data()!),
              toFirestore: (influencer, _) => influencer.toMap())
          .get();

      return snapshot.data();
    } catch (e) {
      print('Error getting influencer ${e.toString()}');
      rethrow;
    }
  }

  @override
  Stream<List<Future<Video?>>> streamInfluencerVideos(
      {required String? influencerId}) {
    print('Id $influencerId');
    try {
      final snaps = _influencerRef
          .doc('l9AEs8tdIiQGosPg1xZ9')
          .collection(Paths.videos)
          .snapshots();

      return snaps.map((event) => event.docs.map((doc) async {
            final videoRef = doc.data()['video'] as DocumentReference?;
            final videoDoc = await videoRef?.get();
            return Video.fromDocument(videoDoc);
          }).toList());
    } catch (e) {
      print('Error geting influencer video ${e.toString()}');
      rethrow;
    }
  }
}
