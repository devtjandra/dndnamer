import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        // backgroundColor: Colors.blue,
      ),
    );
  }
}
