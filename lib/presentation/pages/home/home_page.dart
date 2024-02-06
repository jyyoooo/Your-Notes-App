import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/notes_bloc.dart';
import '../note/note_card.dart';
import 'widgets/new_note_sheet.dart';
import 'widgets/show_snackbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotesBloc>().add(NotesInitialFetchEvent());
    final notesBloc = context.read<NotesBloc>();
 

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton.small(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tooltip: 'Add new note',
          backgroundColor: Colors.teal,
          onPressed: () {
            addNoteSheet(context, notesBloc);
          },
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: IconButton(
                onPressed: () {
                  context.read<NotesBloc>().add(NotesInitialFetchEvent());
                },
                icon: const Icon(
                  CupertinoIcons.refresh,
                  color: Colors.blue,
                )),
          )
        ],
        forceMaterialTransparency: true,
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(top: 35.0),
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
            showSnackbar('New note saved', context);
            notesBloc.add(NotesInitialFetchEvent());
          } else if (state is NotesAddErrorState) {
            showSnackbar('Error updating data', context, Colors.red);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case NotesFetchLoadingState:
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.tealAccent,
              ));
            case NotesSuccessfulFetchState:
              final successState = state as NotesSuccessfulFetchState;
              log('suxsful fetch state');
              // log('suxs  ${successState.notes}');
              return successState.notes.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: successState.notes.length,
                      itemBuilder: (context, index) {
                        final notesFromApi = successState.notes;
                        return NotesWidget(note: notesFromApi[index]);
                      })
                  : const SizedBox(
                      child: Center(
                          child: Text(
                        'No data',
                        style: TextStyle(color: Colors.grey),
                      )),
                    );
            default:
              return const SizedBox(
                child: Center(
                    child: Text(
                  'Couldn\'t load Notes\nTry again',
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
