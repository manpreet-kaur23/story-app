import 'package:bookpad/models/bookmark_model.dart';
import 'package:bookpad/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> addStoryToFirestore(StoryModel storyModel) async {
    String? result;
    String storyId = _firestore.collection("stories").doc().id;
    await _firestore.collection("stories").doc(storyId).set(storyModel.toMap()).whenComplete((){result = storyId;});
    return result;
  }

  Stream<List<StoryModel>> getStoryFromFirestore() {
    return _firestore.collection("stories").snapshots().map((snapshot) => snapshot.docs.map(
        (doc) => StoryModel.fromMap(doc.data(), doc.id)
    ).toList());
  }
  
  Stream<List<StoryModel>> getAdminStories() {
    User? user = _auth.currentUser;

    if (user == null) {
      return Stream.value([]);
    }
    return _firestore.collection("stories").where('authorId', isEqualTo: user.uid).snapshots().map((snapshot) => snapshot.docs.map(
        (doc) => StoryModel.fromMap(doc.data(), doc.id)
    ).toList());
  }

  Future<String?> fetchStoryAuthorName(String uid) async {
    DocumentSnapshot doc = await _firestore.collection("users").doc(uid).get();
    if (doc.exists) {
      return doc['username'];
    } else {
      return null;
    }
  }

  Future<void> bookmarkStory(BookmarkModel bookmarkModel, bool isBookmarked, String? storyId) async {
    String bookmarkId = _firestore.collection("bookmarks").doc().id;
    User? user = _auth.currentUser;
    if (user == null) {
      return Future.error("User not authenticated");
    }
    if (isBookmarked) {
      final snapshot = await _firestore.collection("bookmarks").where("userId", isEqualTo: user.uid).where("storyId", isEqualTo: storyId).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      }
    } else {
      return _firestore.collection("bookmarks").doc(bookmarkId).set(bookmarkModel.toMap());
    }
  }

  Stream<List<StoryModel>> getBookmarkStories() {
    User? user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    return _firestore.collection("bookmarks").where("userId", isEqualTo: user.uid).snapshots().asyncMap((bookmarkSnapshot) async {
      List<String> storyIds = bookmarkSnapshot.docs.map((doc) => doc.get("storyId").toString()).toList();

      if (storyIds.isEmpty) return [];
      final storiesSnapshot = await _firestore.collection("stories").where(FieldPath.documentId, whereIn: storyIds).get();
      return storiesSnapshot.docs.map((doc) => StoryModel.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<bool> isBookmarked(String? storyId) async {
    User? user = _auth.currentUser;
    if (user == null) return false;
    final snapshot = await _firestore.collection("bookmarks").where("userId", isEqualTo: user.uid).where("storyId", isEqualTo: storyId).limit(1).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> deleteStory(String? storyId) async {
    await _firestore.collection("stories").doc(storyId).delete();
  }
}