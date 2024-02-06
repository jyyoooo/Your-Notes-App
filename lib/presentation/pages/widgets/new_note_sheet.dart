import 'package:bloc_api/presentation/pages/widgets/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/note_model.dart';
import '../../bloc/notes_bloc.dart';
import 'custom_text_field.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
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
      
                  // ELEVATED BUTTON
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size.fromWidth(20)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.teal)),
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
                                  description:
                                      descriptionController.text.trim()),
                            ),
                          );
                          Navigator.pop(ctx);
                          FocusScope.of(ctx).unfocus();
                        }
                      },
                      child: const Icon(CupertinoIcons.check_mark,size: 23,),
                    ),
                  ),
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
