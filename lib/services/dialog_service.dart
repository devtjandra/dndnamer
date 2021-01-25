import 'package:dndnamer/config/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter_riverpod/all.dart';

class DialogService {
  static void showFavouritesDialog(
      BuildContext context, String prepopulatedName) {
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();

    if (prepopulatedName != null) _nameController.text = prepopulatedName;

    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return );
        });
  }
}
