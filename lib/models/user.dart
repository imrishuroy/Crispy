// import 'dart:convert';

// class AppUser {
//   final String? handle;
//   final String? imageUrl;
//   final String? userDetailsKey;

//   const AppUser({
//     this.handle,
//     this.imageUrl,
//     this.userDetailsKey,
//   });

//   AppUser copyWith({
//     String? handle,
//     String? imageUrl,
//     String? userDetailsKey,
//   }) {
//     return AppUser(
//       handle: handle ?? this.handle,
//       imageUrl: imageUrl ?? this.imageUrl,
//       userDetailsKey: userDetailsKey ?? this.userDetailsKey,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'handle': handle,
//       'imageUrl': imageUrl,
//       'userDetailsKey': userDetailsKey,
//     };
//   }

//   factory AppUser.fromMap(Map<String, dynamic> map) {
//     return AppUser(
//       handle: map['handle'],
//       imageUrl: map['imageUrl'],
//       userDetailsKey: map['userDetailsKey'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source));

//   @override
//   String toString() =>
//       'User(handle: $handle, imageUrl: $imageUrl, userDetailsKey: $userDetailsKey)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is AppUser &&
//         other.handle == handle &&
//         other.imageUrl == imageUrl &&
//         other.userDetailsKey == userDetailsKey;
//   }

//   @override
//   int get hashCode =>
//       handle.hashCode ^ imageUrl.hashCode ^ userDetailsKey.hashCode;
// }
