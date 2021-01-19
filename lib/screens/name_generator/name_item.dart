import 'package:dndnamer/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NameItem extends StatelessWidget {
  final _controller = SlidableController();
  final String value;

  NameItem(this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      elevation: 3.0,
      child: Slidable(
        controller: _controller,
        actionPane: const SlidableStrechActionPane(),
        secondaryActions: [
          IconSlideAction(
            color: Colors.black87,
            icon: Icons.favorite,
            onTap: () {
              _controller.activeState.close();
              DialogService.showFavouritesDialog(context, value);
            },
            closeOnTap: false,
          ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child: Text(value),
        ),
      ),
    );
  }
}
