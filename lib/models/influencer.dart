import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Influencer extends Equatable {
  final String? name;
  final String? username;
  final String? bio;
  final String? influencerId;
  final String? profilePic;
  // final List<Video?> influencerVideos;

  const Influencer({
    this.name,
    this.username,
    this.bio,
    this.influencerId,
    this.profilePic,
    //  required this.influencerVideos,
  });

  Influencer copyWith({
    String? name,
    String? username,
    String? bio,
    String? influencerId,
    String? profilePic,
    // List<Video?>? influencerVideos,
  }) {
    return Influencer(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      influencerId: influencerId ?? this.influencerId,
      profilePic: profilePic ?? profilePic,
      // influencerVideos: influencerVideos ?? this.influencerVideos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'bio': bio,
      'uid': influencerId,
      'profileImage': profilePic,
    };
  }

  factory Influencer.fromMap(Map<String, dynamic> map) {
    return Influencer(
      name: map['name'],
      username: map['username'],
      bio: map['bio'],
      influencerId: map['uid'],
      profilePic: map['profilePic'],
      //    influencerVideos: map['videos'],
    );
  }

  factory Influencer.fromDocument(DocumentSnapshot? doc) {
    final data = doc?.data() as Map?;

    return Influencer(
      name: data?['name'],
      influencerId: data?['uid'],
      username: data?['username'],
      bio: data?['bio'],
      profilePic: data?['profilePic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Influencer.fromJson(String source) =>
      Influencer.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      username,
      bio,
      influencerId,
      profilePic,
    ];
  }
}
