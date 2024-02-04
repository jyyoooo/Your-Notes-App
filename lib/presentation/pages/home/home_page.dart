import 'dart:developer';

import 'package:bloc_api/core/note_model.dart';
import 'package:bloc_api/presentation/bloc/notes_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notesBloc.add(
            NotesAddEvent(
              note: NotesModel(
                  title: 'Jyothish', description: 'Flutter Developer'),
            ),
          );
        },
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.tealAccent,
        title: const Text(
          'Your Notes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        bloc: notesBloc,
        listenWhen: (previous, current) => current is NotesActionState,
        buildWhen: (previous, current) => current is! NotesActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case NotesFetchLoadingState:
              return const Center(child: CircularProgressIndicator());
            case NotesSuccessfulFetchState:
              final successState = state as NotesSuccessfulFetchState;
              log('suxs state');
              return ListView.builder(
                itemCount: successState.notes.length,
                itemBuilder: (context, index) => Center(
                  child: Container(
                    height: 50,
                    width: 150,
                    color: Colors.yellow,
                    child: Text(successState.notes[index].title),
                  ),
                ),
              );

            default:
              return const SizedBox(
                child: Center(child: Text('No data')),
              );
          }
        },
      ),
    );
  }
}
