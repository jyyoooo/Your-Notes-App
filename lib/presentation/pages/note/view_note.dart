// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_api/presentation/bloc/notes_bloc.dart';
import 'package:bloc_api/presentation/pages/widgets/custom_text_field.dart';
import 'package:bloc_api/presentation/pages/widgets/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/note_model.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: ListView(physics: const BouncingScrollPhysics(),
          children: [
            CustomTextField(
              controller: updatedTitleController,
              border: false,
              fs: 18,
              fw: FontWeight.w500,
            ),
            CustomTextField(
              controller: updatedDescriptionController,
              border: false,
              maxLines: 20,
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
