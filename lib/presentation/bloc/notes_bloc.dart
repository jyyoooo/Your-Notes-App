import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<NotesInitialFetchEvent>(notesInitialFetchEvent);
  }

  FutureOr<void> notesInitialFetchEvent(NotesInitialFetchEvent event, Emitter<NotesState> emit) {
  }
}
