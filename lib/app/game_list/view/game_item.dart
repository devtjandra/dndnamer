import 'package:dndnamer/app/person_creator/view/custom_card.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GameItem extends StatelessWidget {
  final _controller = SlidableController();
  final Game game;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  GameItem({@required this.game, this.onTap, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ClipRRect(
        borderRadius: Styles.sliderClipper,
        child: Slidable(
          controller: _controller,
          actionPane: const SlidableStrechActionPane(),
          secondaryActions: [_editButton(context), _deleteButton(context)],
          child: InkWell(
            onTap: onTap,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    verticalSpace(height: 4.0),
                    Text(game.description, maxLines: 2),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _editButton(BuildContext context) {
    return IconSlideAction(
      color: const Color(0xff585858),
      icon: Icons.edit,
      onTap: () {
        _controller.activeState.close();
        if (onEdit != null) onEdit();
      },
      closeOnTap: false,
    );
  }

  Widget _deleteButton(BuildContext context) {
    return IconSlideAction(
      color: Theme.of(context).accentColor,
      icon: Icons.delete,
      onTap: () {
        _controller.activeState.close();
        if (onDelete != null) onDelete();
      },
      closeOnTap: false,
    );
  }
}
