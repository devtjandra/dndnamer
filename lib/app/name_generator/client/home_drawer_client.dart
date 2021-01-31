import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeDrawerClient {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    return;
  }

  Future<String> getUserName() async {
    return FirebaseFirestore.instance
        .collection("accounts")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => value.get("name") as String);
  }
}
