part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent{}

class NotesInitialFetchEvent extends NotesEvent{}