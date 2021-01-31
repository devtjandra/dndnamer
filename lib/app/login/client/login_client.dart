import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginClient {
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return;
  }

  Future<void> register(String email, String password, String name) async {
    final creds = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await shoveInUser(creds.user.uid, name);
    return;
  }

  Future<void> shoveInUser(String uid, String name) async {
    await FirebaseFirestore.instance
        .collection("accounts")
        .doc(uid)
        .set({"name": name, "currentGame": "", "games": {}});
    return;
  }
}
