import 'package:firebase_auth/firebase_auth.dart';

class LoginClient {
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return;
  }

  Future<void> register(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return;
  }
}
