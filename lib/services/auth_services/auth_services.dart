import 'package:bookpad/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> signupWithEmail(UserModel user, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
      await firestore.collection("users").doc(userCredential.user!.uid).set(user.toMap());
      return null;
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "email-already-in-use":
          return "Error: Email already in use";
        case "invalid-email":
          return "Error: Invalid Email";
        case "network-request-failed":
          return "Network Connection lost.";
        default:
          return "Error: Something went wrong";
      }
    }
  }

  Future<String?> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "invalid-email":
          return "Error: Invalid Email";
        case "user-not-found":
          return "Error: User Not Found";
        case "wrong-password":
          return "Error: Wrong Password";
        case "network-request-failed":
          return "Network Connection lost.";
        default:
          return "Error: Something went wrong";
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
