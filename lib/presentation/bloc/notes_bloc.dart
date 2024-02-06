import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_api/core/note_model.dart';
import 'package:bloc_api/data/notes_repository.dart';
import 'package:flutter/foundation.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitialState()) {
    on<NotesInitialFetchEvent>(notesInitialFetchEvent);
    on<NotesAddEvent>(notesAddEvent);
    on<NotesUpdateEvent>(notesUpdateEvent);
    on<NotesDeleteEvent>(noteDeleteEvent);
  }

  FutureOr<void> notesInitialFetchEvent(
      NotesInitialFetchEvent event, Emitter<NotesState> emit) async {
    log('in on Notesinit fn');
    emit(NotesFetchLoadingState());
    final notes = await NotesRepository.fetchNotes();
    log('notes from fetch in notesInitialFetchEvent :$notes');
    emit(NotesSuccessfulFetchState(notes: notes));
  }

  FutureOr<void> notesAddEvent(
      NotesAddEvent event, Emitter<NotesState> emit) async {
    final isNoteAdded = await NotesRepository.addNote(note: event.note);
    if (isNoteAdded) {
      emit(NotesAddSuccessState());
    } else {
      emit(NotesAddErrorState());
    }
  }

  FutureOr<void> notesUpdateEvent(
      NotesUpdateEvent event, Emitter<NotesState> emit) async {
    log(event.updatedNote.id.toString());
    bool isNoteUpdated =
        await NotesRepository.updateNote(updatedNote: event.updatedNote);
    if (isNoteUpdated) {
      log('note updated');
      emit(NotesUpdateSuccessState());
    } else {
      log('update error');
      emit(NotesUpdateErrorState());
    }
  }

  FutureOr<void> noteDeleteEvent(
      NotesDeleteEvent event, Emitter<NotesState> emit) async {
    bool noteDeleted = await NotesRepository.deleteNote(deleteNoteID: event.id);
    if (noteDeleted) {
      log('deleted');
      emit(NotesDeleteSuccessState());
    } else {
      log('delete error');
      emit(NotesDeleteErrorState());
    }
  }
}
