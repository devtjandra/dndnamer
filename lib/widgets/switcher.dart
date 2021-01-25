import 'package:dndnamer/utils/typedefs.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final IntCallback onItemSelected;

  const Switcher({
    this.options = const [],
    this.selectedIndex = 0,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((e) => optionItem(e)).toList(),
    );
  }

  Widget optionItem(String optionText) {
    final index = options.indexOf(optionText);
    return InkWell(
        onTap: () => onItemSelected(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(optionText,
              style: index == selectedIndex
                  ? Styles.cardTitleText
                  : Styles.hintText),
        ));
  }
}
