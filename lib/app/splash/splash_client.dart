import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashClient {
  Future<bool> loginCheck() async {
    await Firebase.initializeApp();
    return FirebaseAuth.instance.currentUser != null;
  }
}
