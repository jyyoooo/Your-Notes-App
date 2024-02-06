import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/bloc/notes_bloc.dart';
import '../../../../core/note_model.dart';
import 'custom_text_field.dart';
import 'show_snackbar.dart';

addNoteSheet(BuildContext ctx, NotesBloc notesBloc) {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  return showModalBottomSheet(
    backgroundColor: Colors.grey[50],
    enableDrag: true,
    elevation: 1,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: BoxConstraints.expand(
      height: MediaQuery.of(ctx).size.height / 1.06,
    ),
    context: ctx,
    builder: (ctx) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom:15.0),
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            tooltip: 'Add this note',
            backgroundColor: Colors.teal,
            onPressed: () async {
              // int id = DateTime.now().millisecondsSinceEpoch;
              if (titleController.text == '' ||
                  descriptionController.text == '') {
                showSnackbar('Note is empty', ctx, Colors.red);
              } else {
                notesBloc.add(
                  NotesAddEvent(
                    note: NotesModel(
                        // id: id,
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim()),
                  ),
                );
                Navigator.pop(ctx);
                FocusScope.of(ctx).unfocus();
              }
            },
            child: const Icon(
              CupertinoIcons.check_mark,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            width: MediaQuery.of(ctx).size.width,
            child: Form(
              key: formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const Center(
                      child: Text(
                    'Add new note',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
                  const SizedBox(height: 10),
                  CustomTextField(
                    border: false,
                    labelText: 'Title',
                    controller: titleController,
                    fw: FontWeight.w500,
                    fs: 18,
                  ),
                  CustomTextField(
                      border: false,
                      maxLines: 20,
                      labelText: 'Desctiption',
                      controller: descriptionController),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    },
    isDismissible: true,
    showDragHandle: true,
  );
}
