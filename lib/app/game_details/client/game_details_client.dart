import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/models/person.dart';

class GameDetailsClient {
  Future<Game> getGame(String uuid) async {
    final game =
        await FirebaseFirestore.instance.collection("games").doc(uuid).get();

    return Game.fromJson(game.data());
  }

  Future<List<Person>> getPersons(String gameUuid) async {
    final values = await FirebaseFirestore.instance
        .collection("persons")
        .where("gameUuid", isEqualTo: gameUuid)
        .get();

    final personValues = values.docs.map((e) => e.data()).toList();
    return personValues.map((e) => Person.fromJson(e)).toList();
  }

  Future<void> deletePerson(String uuid) async {
    await FirebaseFirestore.instance.collection("persons").doc(uuid).delete();
    return;
  }
}
