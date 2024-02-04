part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialFetchEvent extends NotesEvent {}

class NotesAddEvent extends NotesEvent {
  final NotesModel note;
  NotesAddEvent({required this.note});
}
