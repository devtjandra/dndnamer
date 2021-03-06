import 'package:dndnamer/app/game_creator/client/game_creator_client.dart';
import 'package:dndnamer/app/game_creator/view/game_creator.dart';
import 'package:dndnamer/app/game_details/view/game_details.dart';
import 'package:dndnamer/app/game_list/view/game_list.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/utils/snack.dart';
import 'package:dndnamer/values/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:uuid/uuid.dart';

class GameCreatorViewModel {
  final ProviderReference ref;
  final client = GameCreatorClient();

  GameCreatorViewModel(this.ref) : super();

  Future<void> createClick(BuildContext context) async {
    debugPrint("test");
    if (ref.read(isWaitingGameCreation).state) return;
    debugPrint("test2");

    ref.read(isWaitingGameCreation).state = true;
    final title = ref.read(gameCreatorTitleTextController).text;
    final description = ref.read(gameCreatorDescriptionTextController).text;

    if (title.isEmpty) {
      Snack.showFieldErrorSnack(context);
      return;
    }
    debugPrint("test3");

    final uuid = Uuid();
    final gameUuid = uuid.v4().toString();
    final editUuid = ref.read(editGameUuid).state;

    client
        .createGame(Game(
            uuid: editUuid ?? gameUuid,
            accountUid: FirebaseAuth.instance.currentUser.uid,
            title: title,
            description: description))
        .then((value) {
      ref.read(isWaitingGameCreation).state = false;
      ref.read(gameListViewModel).refreshGame();
      ref.read(gameCreatorTitleTextController).text = "";
      ref.read(gameCreatorDescriptionTextController).text = "";
      ref.read(editGameUuid).state = null;

      if (editUuid != null) {
        ref.read(gameDetailsViewModel).getGame(editUuid);
      }

      Snack.showSnack(context, Strings.toastGameCreation);
      Navigator.of(context).pop();
    }).catchError((error) {
      ref.read(isWaitingGameCreation).state = false;
      debugPrint("Error $error");
    });
  }
}
