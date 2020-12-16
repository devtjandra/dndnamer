import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        // backgroundColor: Colors.blue,
      ),
    );
  }
}
