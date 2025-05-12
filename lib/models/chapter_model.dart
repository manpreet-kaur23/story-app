import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterModel {
  final String? chapterId;
  final String? storyId;  // foreign key - storyId (StoryModel)
  final int chapterNumber;
  final String? title;
  final String? content;
  final int likes;
  final int views;
  final DateTime createdAt;

  ChapterModel({
    this.chapterId,
    this.storyId,
    required this.chapterNumber,
    required this.title,
    required this.content,
    this.likes = 0,
    this.views = 0,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'chapterNumber': chapterNumber,
      'title': title,
      'content': content,
      'likes': likes,
      'views': views,
      'createdAt': createdAt,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map, String docId) {
    return ChapterModel(
        chapterId: docId,
        storyId: map['storyId'],
        chapterNumber: map['chapterNumber'],
        title: map['title'],
        content: map['content'],
        likes: map['likes'],
        views: map['views'],
        createdAt: (map['createdAt'] as Timestamp).toDate()
    );
  }
}