import 'dart:convert';
import 'dart:developer';
import 'package:bloc_api/core/bloc/api.dart';
import 'package:bloc_api/core/note_model.dart';
import 'package:http/http.dart' as http;

// 'data' 'items'
// '$baseUrl/notes'
// const String baseUrl = 'https://api.nstack.in/v1/todos';



class NotesRepository {
  // Fetch notes from API
  static Future<List<NotesModel>> fetchNotes() async {
    var client = http.Client();
    List<NotesModel> notes = [];

    try {
      var response = await client.get(Uri.parse('$baseUrl/notes'));
      // log(' status: ${response.body}');
      // log('note repo fetch status: ${response.statusCode.toString()}');

      if (response.statusCode == 200) {
        final responseData = await jsonDecode(response.body);
        // log('reponsedata ${responseData.toString()}');
        final notesFromJson = responseData['data'];
        // log(' notes from AAAAAAAAAA $notesFromJson');
        // log('items in notes are ${responseData['data']}');
        for (Map<String, dynamic> note in notesFromJson) {
          notes.add(NotesModel.fromMap(note));
        }
      }
      // log('XXXXXXXXXXnotes $notes');
      return notes;
    } catch (exception) {
      log(exception.toString());
      return [];
    }
  }

  // Add new note
  static Future<bool> addNote({required NotesModel note}) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('$baseUrl/note'),
          body: jsonEncode(note.toMap()),
          headers: {'Content-Type': 'application/json'});
      log('add response status: ${response.statusCode}');
      log(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> updateNote({required NotesModel updatedNote}) async {
    var client = http.Client();
    try {
      String url = "$baseUrl/note/${updatedNote.id}";
      log(url);

      var response = await client.put(
        Uri.parse(url),
        body: jsonEncode(updatedNote.toMap()),
        headers: {'Content-Type': 'application/json'},
      );
      log('updation status code: ${response.statusCode}');
      // log(response.body);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> deleteNote({required String deleteNoteID}) async {
    var client = http.Client();
    try {
      String url = "$baseUrl/note/$deleteNoteID";
      // log(url);
      var response = await client.delete(Uri.parse(url));
      log('deletion status code: ${response.statusCode}');
      // log(response.body);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  String formatDateTime(int timestamp) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final day = dateTime.day.toString();
    final month = months[dateTime.month - 1]; // Month index starts from 0
    final year = dateTime.year.toString();

    return '$day $month $year';
  }
}
