import 'package:dndnamer/app/person_creator/logic/person_creator_view_model.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final _viewModel =
    Provider<PersonCreatorViewModel>((ref) => PersonCreatorViewModel(ref));
final personCreatorNameTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final personCreatorDescriptionTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final personCreatorImportance = StateProvider<int>((ref) => 0);
final personCreatorGame = StateProvider<Game>((ref) => null);

class PersonCreatorArguments {
  final String name;

  PersonCreatorArguments({@required this.name});
}

// ignore: must_be_immutable
class PersonCreator extends ConsumerWidget {
  bool _initialNameSet = false;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (!_initialNameSet) {
      _initialNameSet = true;
      final args = ModalRoute.of(context).settings.arguments;

      if (args != null) {
        final personCreatorArgs = args as PersonCreatorArguments;
        watch(personCreatorNameTextController).text = personCreatorArgs.name;
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(Strings.personCreatorTitle),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: const Icon(Icons.close), onPressed: () {})),
                TextField(
                    controller: watch(personCreatorNameTextController),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration.collapsed(
                        hintText: Strings.name,
                        hintStyle: TextStyle(color: Colors.grey))),
                verticalSpace(),
                verticalSpace(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      controller: watch(personCreatorDescriptionTextController),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Description",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
                verticalSpace(),
                Row(children: [
                  Expanded(
                      child: OutlinedButton(
                    // onPressed: () async {
                    //   // final exists = await context
                    //   //     .read(favouritesList)
                    //   //     .doesPersonExist(_nameController.text);
                    //   // SnackBar snackBar;

                    //   // if (exists) {
                    //   //   snackBar = const SnackBar(
                    //   //       content: Text("This name is already saved!"));
                    //   // } else {
                    //   //   context
                    //   //       .read(favouritesList)
                    //   //       .save(_nameController.text, _descriptionController.text);
                    //   //   Navigator.pop(dialogContext);
                    //   //   snackBar = const SnackBar(content: Text("Saved!"));
                    //   // }

                    //   // Scaffold.of(context).showSnackBar(snackBar);
                    // },
                    child: const Text(Strings.createPerson),
                  ))
                ])
              ],
            ),
          ),
        ));
  }
}
