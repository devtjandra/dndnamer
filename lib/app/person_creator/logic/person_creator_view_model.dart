import 'package:dndnamer/app/person_creator/client/person_creator_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class PersonCreatorViewModel {
  final ProviderReference ref;
  final client = PersonCreatorClient();

  PersonCreatorViewModel(this.ref) : super();

  Future<void> add(BuildContext context) {
    
  }
} 