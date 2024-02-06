// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialFetchEvent extends NotesEvent {}

class NotesAddEvent extends NotesEvent {
  final NotesModel note;
  NotesAddEvent({required this.note});
}

class NotesUpdateEvent extends NotesEvent {
  final NotesModel updatedNote;
  NotesUpdateEvent({required this.updatedNote});
}

class NotesDeleteEvent extends NotesEvent {
  final String id;
  NotesDeleteEvent({required this.id});
}
