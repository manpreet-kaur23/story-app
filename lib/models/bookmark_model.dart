class BookmarkModel {
  final String? bookmarkId;
  final String userId;  // foreign key - userId (UserModel)
  final String? storyId; // foreign key - storyId (StoryModel)

  BookmarkModel({
    this.bookmarkId,
    required this.userId,
    required this.storyId
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'storyId': storyId,
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookmarkModel(
        bookmarkId: docId,
        userId: map['userId'],
        storyId: map['storyId']
    );
  }
}