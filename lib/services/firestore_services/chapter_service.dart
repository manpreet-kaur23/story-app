import 'package:bookpad/models/chapter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadChapterToFirestore(ChapterModel chapterModel, String? storyId) {
    String chapterId = _firestore.collection("stories").doc(storyId).collection("chapters").doc().id;
    return _firestore.collection("stories").doc(storyId).collection("chapters").doc(chapterId).set(chapterModel.toMap());
  }

  Stream<List<ChapterModel>> getStoryChapters(String? storyId) {
    return _firestore.collection("stories").doc(storyId).collection("chapters").orderBy("timestamp", descending: true).snapshots().map((snapshot) => snapshot.docs.map(
        (doc) => ChapterModel.fromMap(doc.data(), doc.id)
    ).toList());
  }

  Future<int> getChapterCount(String? storyId) async {
    QuerySnapshot snapshot = await _firestore.collection("stories").doc(storyId).collection("chapters").get();
    return snapshot.size;
  }

}