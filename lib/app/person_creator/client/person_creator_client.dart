import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndnamer/models/person.dart';
import 'package:flutter/material.dart';

class PersonCreatorClient {
  Future<void> addPerson({@required Person person}) async {
    await FirebaseFirestore.instance
        .collection("persons")
        .doc(person.uuid)
        .set(person.toJson());
    return;
  }
}
