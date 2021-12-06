import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crispy/models/video.dart';
import 'package:crispy/repository/video/base_video_repo.dart';

class VideoRepository extends BaseVideoRepositroy {
  final _videoRef = FirebaseFirestore.instance.collection('videos');

  Stream<List<Future<Video?>>> streamVideos() {
    try {
      // final videoSnaps = _videoRef.orderBy('dateTime').snapshots();
      final videoSnaps = _videoRef.snapshots();

      return videoSnaps.map((snaps) {
        print('Video snaps ${snaps.docs.length}');

        return snaps.docs.map((doc) => Video.fromDocument(doc)).toList();
      });
    } catch (e) {
      print('Error getting stream of videos ${e.toString()}');
      rethrow;
    }
  }

  Future<List<Video?>> getVideos() async {
    try {
      //  List<Video?> videos = [];

      final videoSnaps = await _videoRef.orderBy('dateTime').get();

      final videos = Future.wait(
          videoSnaps.docs.map((doc) => Video.fromDocument(doc)).toList());

      return videos;

      // for (var element in data.docs) {
      //   print('Video data ${element.data()}');
      //   videos.add(Video.fromMap(element.data()));
      // }

      //return data.docs.map((doc) => Video.fromMap(doc.data())).toList();

    } catch (e) {
      print('Error getting videos ${e.toString()}');
      rethrow;
    }
  }
}
