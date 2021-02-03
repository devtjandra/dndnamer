import 'package:flutter/material.dart';

Widget background() {
  return Expanded(
      child: Container(
    width: double.infinity,
    decoration: const BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color.fromARGB(15, 0, 0, 0), Color.fromARGB(60, 0, 0, 0)],
    )),
  ));
}