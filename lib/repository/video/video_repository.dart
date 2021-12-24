import 'package:cloud_firestore/cloud_firestore.dart';
import '/contants/paths.dart';
import '/models/comment.dart';
import '/models/video.dart';
import '/repository/video/base_video_repo.dart';

class VideoRepository extends BaseVideoRepositroy {
  final _videoRef = FirebaseFirestore.instance.collection(Paths.videos);
  final _userRef = FirebaseFirestore.instance.collection(Paths.users);
  final _likedRef = FirebaseFirestore.instance.collection(Paths.likes);

  final FirebaseFirestore _firebaseFirestore;

  VideoRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

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
          .collection(Paths.likedVideos)
          .doc(userId)
          .set({});

      await _firebaseFirestore
          .collection(Paths.users)
          .doc(userId)
          .collection(Paths.likedVideos)
          .doc(videoId)
          .set({
        'video': _firebaseFirestore.collection(Paths.videos).doc(videoId)
      });
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
          .doc(video?.videoId)
          .collection(Paths.likedVideos)
          .doc(userId)
          .get();
      if (likeDoc.exists) {
        if (video?.videoId != null) {
          videosIds.add(video!.videoId!);
        }
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
          .collection(Paths.likedVideos)
          .doc(userId)
          .delete();

      await _firebaseFirestore
          .collection(Paths.users)
          .doc(userId)
          .collection(Paths.likedVideos)
          .doc(videoId)
          .delete();
    } catch (error) {
      print('Error in deleting like ${error.toString()}');
    }
  }

  Future<int> getLikesCount({
    required String? videoId,
  }) async {
    try {
      final snaps = await _firebaseFirestore
          .collection(Paths.likes)
          .doc(videoId)
          .collection(Paths.likedVideos)
          .get();

      return snaps.docs.length;
    } catch (error) {
      print('Error in getting likes count ${error.toString()}');
      rethrow;
    }
  }

  Future<int> getCommentsCount({required String? videoId}) async {
    try {
      final snaps = await _firebaseFirestore
          .collection(Paths.comments)
          .doc(videoId)
          .collection(Paths.videoComments)
          .get();

      return snaps.docs.length;
    } catch (e) {
      print('Error in getting comments likes ${e.toString()}');
      rethrow;
    }
  }

  Future<bool?> checkVideoLikeOrNot(
      {required String? userId, required String? videoId}) async {
    try {
      print('User Id ------------ $userId');
      final videoDoc = await _userRef
          .doc(userId)
          .collection(Paths.likedVideos)
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
            .collection(Paths.likedVideos)
            .doc(videoId)
            .get();
        print('Exits ------------ ${videoDoc.exists}');

        if (videoDoc.exists) {
          _userRef
              .doc(userId)
              .collection(Paths.likedVideos)
              .doc(videoId)
              .delete();
        } else {
          await _userRef
              .doc(userId)
              .collection(Paths.likedVideos)
              .doc(videoId)
              .set({
            'video': FirebaseFirestore.instance
                .collection(Paths.videos)
                .doc(videoId),
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

  // Comments section

  Future<void> createComment({
    required Comment comment,
  }) async {
    try {
      _firebaseFirestore
          .collection(Paths.comments)
          .doc(comment.videoId)
          .collection(Paths.videoComments)
          .add(comment.toDocument());
    } catch (error) {
      print('Error in adding comments ${error.toString()}');
      rethrow;
    }
  }

  Stream<List<Future<Comment?>>> getPostComments({required String? videoId}) {
    return _firebaseFirestore
        .collection(Paths.comments)
        .doc(videoId)
        .collection(Paths.videoComments)
        .orderBy('date', descending: false)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => Comment.fromDocument(doc)).toList());
  }

  // User liked videos

  Stream<List<Future<Video?>>> streamUserLikedVideos(
      {required String? userId}) {
    print('user id -------- $userId');
    try {
      final videoSnaps = _firebaseFirestore
          .collection(Paths.users)
          .doc(userId)
          .collection(Paths.likedVideos)
          .snapshots();

      return videoSnaps.map((snaps) {
        return snaps.docs.map((doc) async {
          print('data ------------- ${doc.data()['video']}');
          final DocumentReference videoRef = doc.data()['video'];
          final videoData = await videoRef.get();
          return Video.fromDocument(videoData);
        }).toList();
      });

      // return videoSnaps.map((snaps) {
      //   print('Video snaps ${snaps.docs.length}');

      //   return snaps.docs.map((doc) => Video.fromDocument(doc)).toList();
      // });
    } catch (error) {
      print('Error in getting user liked vieos ${error.toString()}');
      rethrow;
    }
  }
}


//videos ids
//2yqWa2TgPRVMNaunZ5TR - people
//W5t667XTxTUBNryzRJuw - db