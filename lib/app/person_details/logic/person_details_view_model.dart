import 'package:dndnamer/app/game_details/view/game_details.dart';
import 'package:dndnamer/app/person_details/client/person_details_client.dart';
import 'package:dndnamer/app/person_details/view/person_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class PersonDetailsViewModel {
  final ProviderReference ref;
  final client = PersonDetailsClient();

  PersonDetailsViewModel(this.ref) : super();

  Future<void> getPerson(String uuid) async {
    debugPrint("Getting game");
    if (ref.read(isWaitingPersonDetails).state) return;
    ref.read(isWaitingPersonDetails).state = true;

    client.getPerson(uuid).then((value) {
      ref.read(isWaitingPersonDetails).state = false;
      ref.read(personDetails).state = value;
    }).catchError((error) {
      ref.read(isWaitingPersonDetails).state = false;
      debugPrint("Error $error");
    });
  }

  Future<void> deletePerson(BuildContext context) async {
    final person = ref.read(personDetails).state;
    if (person == null) return;
    if (ref.read(isWaitingPersonDelete).state != null) return;

    await ref.read(gameDetailsViewModel).deletePerson(person.uuid);
    Navigator.of(context).pop();
  }
}
