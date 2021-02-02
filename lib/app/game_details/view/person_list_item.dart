import 'package:flutter/material.dart';

class PersonListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const PersonListItem({this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            elevation: 3.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Text(text),
            ),
          ),
        )
      ],
    );
  }
}
