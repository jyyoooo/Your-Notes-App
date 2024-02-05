import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../core/note_model.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({
    super.key,
    required this.note,
  });

  final NotesModel note;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Slidable(
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(label: 'Delete note',
            flex: 1,
            spacing: 0,
            onPressed: (context) {},
            icon: CupertinoIcons.delete,
            foregroundColor: Colors.red,
            backgroundColor: Colors.white12,
          )
        ]),
        child: Card(
          elevation: .4,
          color: Colors.grey[50],
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    note.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey[700],overflow: TextOverflow.fade),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
