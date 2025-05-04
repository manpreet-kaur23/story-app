import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterModel {
  final String chapterId;
  final String storyId;  // foreign key - storyId (StoryModel)
  final int chapterNumber;
  final String title;
  final String content;
  final DateTime createdAt;

  ChapterModel({
    required this.chapterId,
    required this.storyId,
    required this.chapterNumber,
    required this.title,
    required this.content,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'chapterId': chapterId,
      'storyId': storyId,
      'chapterNumber': chapterNumber,
      'title': title,
      'content': content,
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
        createdAt: (map['createdAt'] as Timestamp).toDate()
    );
  }
}