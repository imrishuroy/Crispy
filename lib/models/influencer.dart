import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Influencer extends Equatable {
  final String? name;
  final String? username;
  final String? bio;
  final String? uid;
  final String? profilePic;

  const Influencer({
    this.name,
    this.username,
    this.bio,
    this.uid,
    this.profilePic,
  });

  Influencer copyWith({
    String? name,
    String? username,
    String? bio,
    String? uid,
    String? profilePic,
  }) {
    return Influencer(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'bio': bio,
      'uid': uid,
      'profileImage': profilePic,
    };
  }

  factory Influencer.fromMap(Map<String, dynamic> map) {
    return Influencer(
      name: map['name'],
      username: map['username'],
      bio: map['bio'],
      uid: map['uid'],
      profilePic: map['profilePic'],
    );
  }

  factory Influencer.fromDocument(DocumentSnapshot? doc) {
    final data = doc?.data() as Map?;

    return Influencer(
      name: data?['name'],
      uid: data?['uid'],
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
      uid,
      profilePic,
    ];
  }
}
