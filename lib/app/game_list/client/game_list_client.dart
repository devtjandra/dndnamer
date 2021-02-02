import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndnamer/models/game.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GameListClient {
  Future<List<Game>> getGames() async {
    final values = await FirebaseFirestore.instance
        .collection("games")
        .where("accountUid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    final gameValues = values.docs.map((e) => e.data()).toList();
    return gameValues.map((e) => Game.fromJson(e)).toList();
  }
}
