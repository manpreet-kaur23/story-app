import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String? commentId;
  final String userId;  // foreign key - userId (UserModel)
  final String comment;
  final DateTime timestamp;

  CommentModel({
    this.commentId,
    required this.userId,
    required this.comment,
    required this.timestamp
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'comment': comment,
      'timestamp': timestamp,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map, String docId) {
    return CommentModel(
        commentId: docId,
        userId: map['userId'],
        comment: map['comment'],
        timestamp: (map['timestamp'] as Timestamp).toDate()
    );
  }
}