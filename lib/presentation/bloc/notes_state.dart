// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

abstract class NotesActionState extends NotesState {}

class NotesInitial extends NotesState {}

class NotesSuccessfulFetchState extends NotesState {
  final List<NotesModel> notes;
  NotesSuccessfulFetchState({required this.notes});
}

class NotesErrorFetchState extends NotesState {}

class NotesFetchLoadingState extends NotesState {}

class NotesAddSuccessState extends NotesActionState {}

class NotesAddErrorState extends NotesActionState {}
