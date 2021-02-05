import 'package:dndnamer/app/person_creator/view/custom_card.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NameItem extends StatelessWidget {
  final _controller = SlidableController();
  final VoidCallback onSave;
  final String value;

  NameItem(this.value, {this.onSave});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: ClipRRect(
      borderRadius: Styles.sliderClipper,
      child: Slidable(
        controller: _controller,
        actionPane: const SlidableStrechActionPane(),
        secondaryActions: [_favouriteButton(context)],
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child: Text(value),
        ),
      ),
    ));
  }

  Widget _favouriteButton(BuildContext context) {
    return IconSlideAction(
      icon: Icons.favorite,
      color: Theme.of(context).accentColor,
      onTap: () {
        _controller.activeState.close();
        if (onSave != null) onSave();
      },
      closeOnTap: false,
    );
  }
}
