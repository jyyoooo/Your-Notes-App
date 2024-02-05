import 'package:flutter/material.dart';
import '../../../../core/note_model.dart';
import '../../../bloc/notes_bloc.dart';
import 'custom_text_field.dart';

addNoteSheet(BuildContext ctx, NotesBloc notesBloc) {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  return showModalBottomSheet(
    enableDrag: true,
    elevation: 1,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: BoxConstraints.expand(
      height: MediaQuery.of(ctx).size.height / 1.06,
    ),
    context: ctx,
    builder: (ctx) {
      return Theme(data: ThemeData(primaryColor: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            body: SizedBox(
              width: MediaQuery.of(ctx).size.width,
              child: Form(
                key: formKey,
                child: ListView(physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 10),
                    // TITLE
        
                    const SizedBox(height: 10),
        
                    // TEXT INPUT
                    CustomTextField(
                        labelText: 'Title', controller: titleController,fw: FontWeight.w500,fs: 18,),
                        
                    CustomTextField(
                        maxLines: 20,
                        labelText: 'Desctiption',
                        controller: descriptionController),
        
                    const SizedBox(height: 20),
        
                    // ELEVATED BUTTON
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.tealAccent)),
                        onPressed: () async {
                          int id = DateTime.now().millisecondsSinceEpoch;
        
                          if (titleController.text == '' ||
                              descriptionController.text == '') {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                showCloseIcon: true,
                                content: Text('Fill all fields!'),
                                backgroundColor: Colors.red,
                                margin: EdgeInsets.all(15),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            notesBloc.add(
                              NotesAddEvent(
                                note: NotesModel(id: id.toString(),
                                    title: titleController.text.trim(),
                                    description: descriptionController.text.trim()),
                              ),
                            );
                            Navigator.pop(ctx);
                            FocusScope.of(ctx).unfocus();
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 980),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                content: const Text('New note added'),
                                backgroundColor: Colors.teal,
                                margin: const EdgeInsets.all(15),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
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
