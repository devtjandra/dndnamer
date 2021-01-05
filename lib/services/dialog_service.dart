import 'package:flutter/material.dart';
import 'package:dndnamer/services/favourites_hive.dart';
import 'package:dndnamer/widgets/spaces.dart';

class DialogService {
  static void showFavouritesDialog(
      BuildContext context, String prepopulatedName) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    if (prepopulatedName != null) _nameController.text = prepopulatedName;

    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Dialog(
              child: Container(
            height: 300,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(dialogContext))),
                TextField(
                  controller: _nameController,
                  maxLines: 1,
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
                    onPressed: () {
                      debugPrint(
                          "Saving ${_nameController.text}, desc ${_descriptionController.text}");
                      FavouritesHive.save(
                          _nameController.text, _descriptionController.text);
                      Navigator.pop(dialogContext);
                    },
                    child: Text("SAVE TO FAVOURITES"),
                  ))
                ])
              ],
            ),
          ));
        });
  }
}
