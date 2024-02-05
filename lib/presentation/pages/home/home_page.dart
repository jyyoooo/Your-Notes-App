import 'dart:developer';

import 'package:bloc_api/core/note_model.dart';
import 'package:bloc_api/presentation/bloc/notes_bloc.dart';
import 'package:bloc_api/presentation/pages/home/widgets/new_note_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/note_card.dart';
import 'widgets/show_snackbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NotesBloc notesBloc = NotesBloc();
  @override
  void initState() {
    super.initState();
    notesBloc.add(NotesInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    // context.read<NotesBloc>();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   context.read<NotesBloc>().add(NotesInitialFetchEvent());
    // });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        onPressed: () {
          addNoteSheet(context, notesBloc);
        },
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Text(
            'Your Notes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        bloc: notesBloc,
        listenWhen: (previous, current) => current is NotesActionState,
        buildWhen: (previous, current) => current is! NotesActionState,
        listener: (context, state) {
          if (state is NotesAddSuccessState) {
            showSnackbar('Note added successfully!', context);

            notesBloc.add(NotesInitialFetchEvent());
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case NotesFetchLoadingState:
              return const Center(child: CircularProgressIndicator());
            case NotesSuccessfulFetchState:
              final successState = state as NotesSuccessfulFetchState;
              log('suxs state');
              return successState.notes.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: successState.notes.length,
                      itemBuilder: (context, index) {
                        final reversedNotes = successState.notes;
                        return NotesWidget(note: reversedNotes[index]);
                      })
                  : const SizedBox(
                      child: Center(child: Text('No data')),
                    );

            default:
              return const SizedBox(
                child: Center(
                    child: Text(
                  'Could\'nt load Notes\nTry again',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )),
              );
          }
        },
      ),
    );
  }
}
