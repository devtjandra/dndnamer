import 'package:dndnamer/app/game_details/client/game_details_client.dart';
import 'package:dndnamer/app/game_details/view/game_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class GameDetailsViewModel {
  final ProviderReference ref;
  final client = GameDetailsClient();

  GameDetailsViewModel(this.ref) : super();

  Future<void> getGame(String uuid) async {
    debugPrint("Getting game");
    if (ref.read(isWaitingGameDetails).state) return;
    ref.read(isWaitingGameDetails).state = true;

    client.getGame(uuid).then((value) {
      ref.read(isWaitingGameDetails).state = false;
      ref.read(gameDetails).state = value;
      getPersons();
    }).catchError((error) {
      ref.read(isWaitingGameDetails).state = false;
      debugPrint("Error $error");
    });
  }

  Future<void> getPersons() async {
    debugPrint("Getting persons");
    final game = ref.read(gameDetails).state;
    if (game == null) return;
    if (ref.read(isWaitingPersonsList).state) return;
    ref.read(isWaitingPersonsList).state = true;

    client.getPersons(game.uuid).then((value) {
      ref.read(isWaitingPersonsList).state = false;
      ref.read(personsList).state = value;
    }).catchError((error) {
      ref.read(isWaitingPersonsList).state = false;
      ref.read(personsList).state = [];
      debugPrint("Error $error");
    });
  }
}
