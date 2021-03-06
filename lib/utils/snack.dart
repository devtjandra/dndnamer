import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';

class Snack {
  static void showFieldErrorSnack(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(const SnackBar(content: Text(Strings.errorFields)));
  }

  static void showSnack(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
