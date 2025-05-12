import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  final String? storyId;
  final String authorId;  // foreign key - userId (UserModel)
  final String title;
  final String summary;
  final String mainGenre;
  final List<String> subGenres;
  final List<String> tags;
  final String? coverImage;
  final bool isCompleted;
  final int likes;
  final int views;
  final DateTime createdAt;

  StoryModel({
    this.storyId,
    required this.authorId,
    required this.title,
    required this.summary,
    required this.mainGenre,
    required this.subGenres,
    required this.tags,
    this.coverImage,
    required this.isCompleted,
    this.likes = 0,
    this.views = 0,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'title': title,
      'summary': summary,
      'mainGenre': mainGenre,
      'subGenres': subGenres,
      'tags': tags,
      'coverImage': coverImage,
      'isCompleted': isCompleted,
      'likes': likes,
      'views': views,
      'createdAt': createdAt,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map, String docId) {
    return StoryModel(
        storyId: docId,
        authorId: map['authorId'],
        title: map['title'],
        summary: map['summary'],
        mainGenre: map['mainGenre'],
        subGenres: List<String>.from(map['subGenres']),
        coverImage: map['coverImage'],
        tags: List<String>.from(map['tags']),
        isCompleted: map['isCompleted'],
        likes: map['likes'],
        views: map['views'],
        createdAt: (map['createdAt'] as Timestamp).toDate()
    );
  }
}