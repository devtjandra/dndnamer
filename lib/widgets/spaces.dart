import 'package:flutter/material.dart';

Widget horizontalSpace() {
  return Container(
    width: 12.0,
    height: 1.0,
  );
}

Widget verticalSpace() {
  return Container(
    width: 1.0,
    height: 12.0,
  );
}

Widget shadow() {
  return Container(
      height: 12.0,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          const Color(0x1a000000),
          const Color(0x00ffffff),
        ],
      )));
}
