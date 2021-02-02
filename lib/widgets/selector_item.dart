import 'package:dndnamer/widgets/horizontal_line.dart';
import 'package:flutter/material.dart';

class SelectorItem extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SelectorItem({this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(text),
          ),
        ),
        HorizontalLine()
      ],
    );
  }
}
