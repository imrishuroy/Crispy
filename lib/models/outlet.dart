import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Outlet extends Equatable {
  final String? outletImg;

  final String? outletId;

  final int? rattings;

  final String? phNo;
  final String? address;
  final String? website;

  final String? name;
  final GeoPoint? location;

  final String? about;

  const Outlet({
    this.outletId,
    this.outletImg,
    this.name,
    this.location,
    this.about,
    this.address,
    this.phNo,
    this.rattings,
    this.website,
  });

  Outlet copyWith({
    String? outletId,
    String? name,
    GeoPoint? location,
    String? about,
    String? outletImg,
    String? address,
    int? rattings,
  }) {
    return Outlet(
      outletId: outletId ?? this.outletId,
      address: address ?? this.address,
      rattings: rattings ?? this.rattings,
      name: name ?? this.name,
      location: location ?? this.location,
      about: about ?? this.about,
      outletImg: outletImg ?? this.outletImg,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'outletId': outletId,
      'name': name,
      // 'location': location?.toMap(),
      'location': location,
      'about': about,
      'outletPic': outletImg,
    };
  }

  factory Outlet.fromMap(Map<String, dynamic> map) {
    return Outlet(
      outletId: map['outletId'],
      name: map['name'],
      location:
          // map['location'] != null ? GeoPoint.fromMap(map['location']) : null,
          map['location'],
      about: map['about'],
      outletImg: map['outletImg'],
      address: map['address'],
      phNo: map['phNo'],
    );
  }

  // static Future<Outlet?> fromDoc(DocumentReference? doc) async {
  //   if (doc == null) return null;
  //   final data = await doc.get();
  //   print('Outler data $data');
  //   // data() as Map?;
  //   final authorRef = data['author'] as DocumentReference?;
  //   if (authorRef != null) {
  //     final authorDoc = await authorRef.get();
  //     if (authorDoc.exists) {
  //       return Outlet(
  //         rattings: data['rattings'],
  //         outletId: data['outletId'],
  //         name: data['name'],
  //         location: data['location'],
  //         address: data['address'],
  //         phNo: data['phNo'],
  //         about: data['about'],
  //         outletImg: data['outletImg'],
  //       );
  //     }
  //   }
  // }

  factory Outlet.fromDocument(DocumentSnapshot? doc) {
    print('Data type ${doc.runtimeType}');
    // if (doc == null) return null;
    final data = doc?.data() as Map?;

    //final GeoPoint geoPoint = GeoPoint(latitude, longitude)

    print('Location ${data?['location']}');
    print('Outler data $data');
    return Outlet(
      outletId: data?['outletId'],
      name: data?['name'],
      location: data?['location'],
      about: data?['about'],
      outletImg: data?['outletImg'],
      address: data?['address'],
      rattings: data?['rattings'],
      phNo: data?['phNo'],
      website: data?['website'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Outlet.fromJson(String source) => Outlet.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [outletId, name, location, about];
}
