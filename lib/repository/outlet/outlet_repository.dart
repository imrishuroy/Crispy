import 'package:cloud_firestore/cloud_firestore.dart';
import '/contants/paths.dart';
import '/models/outlet.dart';
import '/models/video.dart';
import 'package:dio/dio.dart';

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

  Future<Outlet?> getOutletFromPlaceId({required String? placeId}) async {
    try {
      final _dio = Dio();
      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCWjmMNRDr1881C34m8p4iTac6ocqWdlYI');

      print('Response ----------- $response');
    } catch (e) {
      print('Error in getting place details ${e.toString()}');
      rethrow;
    }
  }
}
