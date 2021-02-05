import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final Color color;

  const ProgressBar({this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor:
            AlwaysStoppedAnimation<Color>(color ?? const Color(0xffbf283a)),
      ),
    );
  }
}
