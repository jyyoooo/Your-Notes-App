part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

abstract class NotesActionState extends NotesState {}

class NotesInitialState extends NotesState {}

class NotesSuccessfulFetchState extends NotesState {
  final List<NotesModel> notes;
  NotesSuccessfulFetchState({required this.notes});
}

class NotesFetchLoadingState extends NotesState {}
class NotesFetchErrorState extends NotesState {}

class NotesAddSuccessState extends NotesActionState {}
class NotesAddErrorState extends NotesActionState {}

class NotesUpdateSuccessState extends NotesActionState {}
class NotesUpdateErrorState extends NotesActionState {}

class NotesDeleteSuccessState extends NotesActionState {}
class NotesDeleteErrorState extends NotesActionState {}
