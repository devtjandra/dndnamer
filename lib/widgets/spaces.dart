import 'package:flutter/material.dart';

Widget horizontalSpace() {
  return const SizedBox(
    width: 12.0,
    height: 1.0,
  );
}

Widget verticalSpace() {
  return const SizedBox(
    width: 1.0,
    height: 12.0,
  );
}

Widget shadow() {
  return Container(
      height: 12.0,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color(0x1a000000),
          Color(0x00ffffff),
        ],
      )));
}
