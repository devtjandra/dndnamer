import 'package:dndnamer/app/person_creator/view/custom_card.dart';
import 'package:dndnamer/models/person.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PersonListItem extends StatelessWidget {
  final _controller = SlidableController();
  final VoidCallback onTap;
  final Person person;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  PersonListItem(
      {@required this.person, this.onTap, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomCard(
            child: ClipRRect(
              borderRadius: Styles.sliderClipper,
              child: Slidable(
                controller: _controller,
                actionPane: const SlidableStrechActionPane(),
                secondaryActions: [
                  _editButton(context),
                  _deleteButton(context)
                ],
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 24.0),
                    child: Text(person.name, maxLines: 2),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
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
