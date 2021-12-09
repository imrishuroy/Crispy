import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';

import 'appuser.dart';

class Comment extends Equatable {
  final String? id;
  final String? videoId;
  final AppUser? author;
  final String? content;
  final DateTime date;

  const Comment({
    this.id,
    required this.videoId,
    required this.author,
    required this.content,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        videoId,
        author,
        content,
        date,
      ];

  Comment copyWith({
    String? id,
    String? videoId,
    AppUser? author,
    String? content,
    DateTime? date,
  }) {
    return Comment(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
      author: author ?? this.author,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'postId': videoId,
      'author': FirebaseFirestore.instance.collection('users').doc(author?.uid),
      'content': content,
      'date': Timestamp.fromDate(date),
    };
  }

  static Future<Comment?> fromDocument(DocumentSnapshot? doc) async {
    if (doc == null) return null;
    final data = doc.data() as Map?;
    final authorRef = data?['author'] as DocumentReference?;
    if (authorRef != null) {
      final authorDoc = await authorRef.get();
      if (authorDoc.exists) {
        return Comment(
          id: doc.id,
          videoId: data?['postId'] ?? '',
          author: AppUser.fromDocument(authorDoc),
          content: data?['content'] ?? '',
          date: (data?['date'] as Timestamp).toDate(),
        );
      }
    }
    return null;
  }
}
