import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '/models/influencer.dart';
import '/models/outlet.dart';

class Video extends Equatable {
  final String? videoId;
  final String? videoUrl;
  final DateTime? dateTime;
  final Influencer? influencer;
  final Outlet? outlet;

  const Video({
    required this.videoId,
    this.videoUrl,
    this.dateTime,
    this.influencer,
    this.outlet,
  });

  Video copyWith({
    String? videoId,
    String? videoUrl,
    DateTime? dateTime,
    Influencer? influencer,
    Outlet? outlet,
  }) {
    return Video(
      videoId: videoId ?? this.videoId,
      videoUrl: videoUrl ?? this.videoUrl,
      dateTime: dateTime ?? this.dateTime,
      influencer: influencer ?? this.influencer,
      outlet: outlet ?? this.outlet,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'video': videoUrl,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'influencer': influencer?.toMap(),
      'outlet': outlet?.toMap(),
    };
  }

  static Future<Video?> fromDocument(DocumentSnapshot? doc) async {
    print('Prince $doc');
    print('Prince ${doc.runtimeType}');
    if (doc != null) {
      print('Prince ${doc.data()}');
    }

    if (doc == null) return null;
    final data = doc.data() as Map?;
    final outletRef = data?['outlet'] as DocumentReference?;
    final influencerRef = data?['influencer'] as DocumentReference?;
    if (outletRef != null && influencerRef != null) {
      final outletDoc = await outletRef.get();
      final influencerDoc = await influencerRef.get();
      if (outletDoc.exists && influencerDoc.exists) {
        return Video(
          videoId: data?['videoId'],
          videoUrl: data?['video'],
          dateTime: data?['dateTime'] != null
              ? DateTime.fromMillisecondsSinceEpoch(data?['dateTime'])
              : null,
          influencer: Influencer.fromDocument(influencerDoc),
          outlet: Outlet.fromDocument(outletDoc),
        );
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [videoId, videoUrl, dateTime, influencer, outlet];
}
