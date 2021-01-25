import 'package:dndnamer/models/person.dart';
import 'package:dndnamer/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_riverpod/all.dart';

class PersonItem extends StatelessWidget {
  final _controller = SlidableController();
  final Person value;

  PersonItem(this.value);

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
            color: const Color(0xffbf283a),
            icon: Icons.delete,
            onTap: () {
              _controller.activeState.close();
              context.read(favouritesList).delete(value.name);
            },
            closeOnTap: false,
          ),
        ],
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value.description)
          ]),
        ),
      ),
    );
  }
}
