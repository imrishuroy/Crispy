import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crispy/contants/paths.dart';
import 'package:crispy/models/outlet.dart';
import 'package:crispy/models/video.dart';

import 'base_outlet_repo.dart';

class OutletRepository extends BaseOutletRepository {
  final _influencerRef = FirebaseFirestore.instance.collection('outlets');

  Future<Outlet?> getOutlet({required String? influencerId}) async {
    try {
      final snapshot = await _influencerRef
          .doc('l9AEs8tdIiQGosPg1xZ9')
          .withConverter<Outlet>(
              fromFirestore: (snapshot, _) => Outlet.fromMap(snapshot.data()!),
              toFirestore: (influencer, _) => influencer.toMap())
          .get();

      return snapshot.data();
    } catch (e) {
      print('Error getting influencer ${e.toString()}');
      rethrow;
    }
  }

  Stream<List<Future<Video?>>> streamOutletVideos({required String? outletId}) {
    print('Id $outletId');
    try {
      final snaps =
          _influencerRef.doc(outletId).collection(Paths.videos).snapshots();

      return snaps.map((event) => event.docs.map((doc) async {
            final videoRef = doc.data()['video'] as DocumentReference?;
            final videoDoc = await videoRef?.get();
            print('Video doc ----------- $videoDoc');
            return Video.fromDocument(videoDoc);
          }).toList());
    } catch (e) {
      print('Error geting influencer video ${e.toString()}');
      rethrow;
    }
  }
}
