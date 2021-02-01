import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndnamer/models/game.dart';

class GameCreatorClient {
  Future<void> createGame(Game game) async {
    await FirebaseFirestore.instance
        .collection("games")
        .doc(game.uuid)
        .set(game.toJson());
    return;
  }
}