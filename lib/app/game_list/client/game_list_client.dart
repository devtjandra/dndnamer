import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/models/person.dart';
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

  Future<void> deleteGame(String uuid) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection("games").doc(uuid).delete();
    final persons = await firestore
        .collection("persons")
        .where("gameUuid", isEqualTo: uuid)
        .get();

    final personValues = persons.docs.map((e) => e.data()).toList();
    final personList = personValues.map((e) => Person.fromJson(e)).toList();

    for (final person in personList) {
      await firestore.collection("persons").doc(person.uuid).delete();
    }

    return;
  }
}
