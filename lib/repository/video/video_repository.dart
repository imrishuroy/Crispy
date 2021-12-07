import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crispy/models/video.dart';
import 'package:crispy/repository/video/base_video_repo.dart';

class VideoRepository extends BaseVideoRepositroy {
  final _videoRef = FirebaseFirestore.instance.collection('videos');
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _likedRef = FirebaseFirestore.instance.collection('likes');

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

  Future<void> createLike({
    required String? videoId,
    required String? userId,
  }) async {
    try {
      await _likedRef
          .doc(videoId)
          .collection('liked-videos')
          .doc(userId)
          .set({});
    } catch (error) {
      print('Error in creating like ${error.toString()}');
      rethrow;
    }
  }

  Future<Set<String>> getLikedVideoIds({
    required String? userId,
    required List<Video?>? videos,
  }) async {
    final videosIds = <String>{};
    for (final video in videos!) {
      final likeDoc = await _likedRef
          .doc(video!.videoId)
          .collection('liked-videos')
          .doc(userId)
          .get();
      if (likeDoc.exists) {
        videosIds.add(video.videoId!);
      }
    }
    return videosIds;
  }

  Future<void> deleteLike({
    required String? videoId,
    required String? userId,
  }) async {
    try {
      await _likedRef
          .doc(videoId)
          .collection('liked-videos')
          .doc(userId)
          .delete();
    } catch (error) {
      print('Error in deleting like ${error.toString()}');
    }
  }

  Future<bool?> checkVideoLikeOrNot(
      {required String? userId, required String? videoId}) async {
    try {
      print('User Id ------------ $userId');
      final videoDoc = await _userRef
          .doc(userId)
          .collection('liked-videos')
          .doc(videoId)
          .get();

      return videoDoc.exists;
    } catch (error) {
      print('Error in getting check video like ${error.toString()}');
      //return false;
      rethrow;
    }
  }

  Future<void> likeVideo({
    required String? userId,
    required String? videoId,
  }) async {
    try {
      if (videoId != null && userId != null) {
        final videoDoc = await _userRef
            .doc(userId)
            .collection('liked-videos')
            .doc(videoId)
            .get();
        print('Exits ------------ ${videoDoc.exists}');

        if (videoDoc.exists) {
          _userRef.doc(userId).collection('liked-videos').doc(videoId).delete();
        } else {
          await _userRef
              .doc(userId)
              .collection('liked-videos')
              .doc(videoId)
              .set({
            'video':
                FirebaseFirestore.instance.collection('videos').doc(videoId),
          });
        }

        // _videoRef.doc(videoId);
      }
    } catch (error) {
      print('Error liking a video ${error.toString()}');
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
