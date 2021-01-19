import 'package:dndnamer/config/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter_riverpod/all.dart';

final favouritesList = StateNotifierProvider<FavouritesListNotifier>(
    (ref) => FavouritesListNotifier(ref));

class DialogService {
  static void showFavouritesDialog(
      BuildContext context, String prepopulatedName) {
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();

    if (prepopulatedName != null) _nameController.text = prepopulatedName;

    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Dialog(
              child: Container(
            height: 300,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(dialogContext))),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration.collapsed(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                verticalSpace(),
                verticalSpace(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      controller: _descriptionController,
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
                      child: ElevatedButton(
                    onPressed: () async {
                      final exists = await context
                          .read(favouritesList)
                          .doesPersonExist(_nameController.text);
                      SnackBar snackBar;

                      if (exists) {
                        snackBar = const SnackBar(
                            content: Text("This name is already saved!"));
                      } else {
                        context.read(favouritesList).save(
                            _nameController.text, _descriptionController.text);
                        Navigator.pop(dialogContext);
                        snackBar = const SnackBar(content: Text("Saved!"));
                      }

                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: const Text("SAVE TO FAVOURITES"),
                  ))
                ])
              ],
            ),
          ));
        });
  }
}
