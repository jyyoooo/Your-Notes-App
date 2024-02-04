import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_api/core/note_model.dart';
import 'package:bloc_api/data/notes_repository.dart';
import 'package:flutter/foundation.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<NotesInitialFetchEvent>(notesInitialFetchEvent);
    on<NotesAddEvent>(notesAddEvent);
  }

  FutureOr<void> notesInitialFetchEvent(
      NotesInitialFetchEvent event, Emitter<NotesState> emit) async {
    log('in on Notesinit fn');
    emit(NotesFetchLoadingState());
    final notes = await NotesRepository.fetchNotes();
    emit(NotesSuccessfulFetchState(notes: notes));
  }

  FutureOr<void> notesAddEvent(
      NotesAddEvent event, Emitter<NotesState> emit) async {
    final noteAdded = await NotesRepository.addNote(note: event.note);
    if (noteAdded) {
      emit(NotesAddSuccessState());
    } else {
      emit(NotesAddErrorState());
    }
  }
}
