import 'package:dndnamer/app/game_details/view/game_details.dart';
import 'package:dndnamer/app/person_creator/client/person_creator_client.dart';
import 'package:dndnamer/app/person_creator/view/person_creator.dart';
import 'package:dndnamer/app/person_details/view/person_details.dart';
import 'package:dndnamer/models/person.dart';
import 'package:dndnamer/utils/snack.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:uuid/uuid.dart';

class PersonCreatorViewModel {
  final ProviderReference ref;
  final client = PersonCreatorClient();

  PersonCreatorViewModel(this.ref) : super();

  Future<void> add(BuildContext context) async {
    if (ref.read(isWaitingPersonCreation).state) return;

    ref.read(isWaitingPersonCreation).state = true;
    final name = ref.read(personCreatorNameTextController).text;
    final description = ref.read(personCreatorDescriptionTextController).text;
    final game = ref.read(personCreatorGame).state;
    final importance = ref.read(personCreatorImportance).state;

    if (name.isEmpty || game == null) {
      Snack.showFieldErrorSnack(context);
      return;
    }

    final uuid = Uuid();
    final personUuid = uuid.v4().toString();
    final editUuid = ref.read(editPersonUuid).state;

    client
        .createPerson(Person(
            uuid: editUuid ?? personUuid,
            gameUuid: game.uuid,
            name: name,
            importance: importance,
            description: description))
        .then((value) {
      ref.read(isWaitingPersonCreation).state = false;
      ref.read(personCreatorNameTextController).text = "";
      ref.read(personCreatorDescriptionTextController).text = "";
      ref.read(personCreatorImportance).state = 0;
      ref.read(gameDetailsViewModel).getPersons();

      if (editUuid != null) {
        ref.read(personDetailsViewModel).getPerson(editUuid);
      }

      Snack.showSnack(context, Strings.toastCharacterCreation);
      Navigator.of(context).pop();
    }).catchError((error) {
      ref.read(isWaitingPersonCreation).state = false;
      debugPrint("Error $error");
    });
  }
}
