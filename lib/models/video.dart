import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '/models/influencer.dart';
import '/models/outlet.dart';

class Video extends Equatable {
  final String? videoUrl;
  final DateTime? dateTime;
  final Influencer? influencer;
  final Outlet? outlet;
  const Video({
    this.videoUrl,
    this.dateTime,
    this.influencer,
    this.outlet,
  });

  Video copyWith({
    String? videoUrl,
    DateTime? dateTime,
    Influencer? influencer,
    Outlet? outlet,
  }) {
    return Video(
      videoUrl: videoUrl ?? this.videoUrl,
      dateTime: dateTime ?? this.dateTime,
      influencer: influencer ?? this.influencer,
      outlet: outlet ?? this.outlet,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'video': videoUrl,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'influencer': influencer?.toMap(),
      'outlet': outlet?.toMap(),
    };
  }

  static Future<Video?> fromDocument(DocumentSnapshot? doc) async {
    if (doc == null) return null;
    final data = doc.data() as Map?;
    final outletRef = data?['outlet'] as DocumentReference?;
    final influencerRef = data?['influencer'] as DocumentReference?;
    if (outletRef != null && influencerRef != null) {
      final outletDoc = await outletRef.get();
      final influencerDoc = await influencerRef.get();
      if (outletDoc.exists && influencerDoc.exists) {
        return Video(
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
  List<Object?> get props => [videoUrl, dateTime, influencer, outlet];
}
