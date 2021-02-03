import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dndnamer/models/person.dart';

class PersonDetailsClient {
  Future<Person> getPerson(String uuid) async {
    final person =
        await FirebaseFirestore.instance.collection("persons").doc(uuid).get();

    return Person.fromJson(person.data());
  }
}
