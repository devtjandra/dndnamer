import 'package:flutter/material.dart';

class NameItem extends StatelessWidget {
  final String value;

  NameItem(this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      elevation: 3.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        child: Text(value),
      ),
    );
  }
}
