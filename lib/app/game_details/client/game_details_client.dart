import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/models/person.dart';

class GameDetailsClient {
  Future<Game> getGame(String uuid) async {
    final values = await FirebaseFirestore.instance
        .collection("games")
        .where("uuid", isEqualTo: uuid)
        .get();

    final gameValues = values.docs.map((e) => e.data()).toList();
    return gameValues.map((e) => Game.fromJson(e)).toList()[0];
  }

  Future<List<Person>> getPersons(String gameUuid) async {
    final values = await FirebaseFirestore.instance
        .collection("persons")
        .where("gameUuid", isEqualTo: gameUuid)
        .get();

    final personValues = values.docs.map((e) => e.data()).toList();
    return personValues.map((e) => Person.fromJson(e)).toList();
  }
}
