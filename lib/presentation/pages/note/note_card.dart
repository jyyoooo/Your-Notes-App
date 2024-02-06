import 'package:bloc_api/presentation/bloc/notes_bloc.dart';
import 'package:bloc_api/presentation/pages/widgets/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/note_model.dart';
import 'view_note.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({
    super.key,
    required this.note,
  });

  final NotesModel note;

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = NotesBloc();
    return Center(
      child: Slidable(
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(12),
            label: 'Delete note',
            onPressed: (context) {
              notesBloc.add(NotesDeleteEvent(id: note.id!));
              context.read<NotesBloc>().add(NotesInitialFetchEvent());
              showSnackbar('Note deleted', context,Colors.blue);
            },
            icon: CupertinoIcons.delete,
            foregroundColor: Colors.red,
            backgroundColor: Colors.white12,
          )
        ]),
        child: Card(
          elevation: .4,
          color: Colors.grey[50],
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewNote(note: note)));
            },
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            note.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      note.description,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.grey[700],
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
