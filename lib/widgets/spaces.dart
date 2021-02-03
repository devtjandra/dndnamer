import 'package:flutter/material.dart';

Widget horizontalSpace({double width}) {
  return SizedBox(
    width: width ?? 12.0,
    height: 1.0,
  );
}

Widget verticalSpace({double height}) {
  return SizedBox(
    width: 1.0,
    height: height ?? 12.0,
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
          Color(0x22000000),
          Color(0x00000000),
        ],
      )));
}
