import 'package:bookpad/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addStoryComment(String? storyId, CommentModel commentModel) {
    String commentId = firestore.collection("comments").doc().id;
    return firestore.collection("stories").doc(storyId).collection("comments").doc(commentId).set(commentModel.toMap());
  }

  Future<void> deleteStoryComment(String? storyId, String? commentId) {
    return firestore.collection("stories").doc(storyId).collection("comments").doc(commentId).delete();
  }

  Stream<List<CommentModel>> getStoryComments(String? storyId) {
    return firestore.collection("stories").doc(storyId).collection("comments").snapshots().map((snapshot) => snapshot.docs.map(
        (doc) => CommentModel.fromMap(doc.data(), doc.id)
    ).toList());
  }
}