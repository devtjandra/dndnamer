import 'package:dndnamer/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GameItem extends StatelessWidget {
  final _controller = SlidableController();
  final Game game;

  GameItem(this.game);

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
        secondaryActions: [_editButton(context), _deleteButton(context)],
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(game.description, maxLines: 2),
              ],
            )),
      ),
    );
  }

  Widget _editButton(BuildContext context) {
    return IconSlideAction(
      color: Colors.black87,
      icon: Icons.edit,
      onTap: () {
        _controller.activeState.close();
        // TODO: Edit
      },
      closeOnTap: false,
    );
  }

  Widget _deleteButton(BuildContext context) {
    return IconSlideAction(
      color: Colors.black87,
      icon: Icons.delete,
      onTap: () {
        _controller.activeState.close();
        // TODO: Delete
      },
      closeOnTap: false,
    );
  }
}
