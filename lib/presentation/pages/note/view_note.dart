import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/notes_bloc.dart';
import '../../../core/note_model.dart';
import '../../../data/notes_repository.dart';
import '../home/widgets/custom_text_field.dart';
import '../home/widgets/show_snackbar.dart';

class ViewNote extends StatelessWidget {
  const ViewNote({Key? key, required this.note}) : super(key: key);
  final NotesModel note;

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = NotesBloc();
    TextEditingController updatedTitleController =
        TextEditingController(text: note.title);
    TextEditingController updatedDescriptionController =
        TextEditingController(text: note.description);
    final createdAt = NotesRepository().formatDateTime(note.updatedAt!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              createdAt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey),
            ),
            CustomTextField(
              controller: updatedTitleController,
              border: false,
              fs: 18,
              fw: FontWeight.w500,
            ),
            CustomTextField(
              controller: updatedDescriptionController,
              border: false,
              maxLines: 23,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  notesBloc.add(NotesUpdateEvent(
                      updatedNote: NotesModel(
                          // isCompleted: true,
                          id: note.id,
                          createdAt: note.createdAt,
                          updatedAt: note.updatedAt,
                          title: updatedTitleController.text.trim(),
                          description:
                              updatedDescriptionController.text.trim())));
                  showSnackbar('Note updated', context, Colors.blue);
                  context.read<NotesBloc>().add(NotesInitialFetchEvent());
                },
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.teal)),
                child: const SizedBox.square(
                  dimension: 20,
                  child: Icon(
                    CupertinoIcons.cloud_upload,
                    size: 23,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
