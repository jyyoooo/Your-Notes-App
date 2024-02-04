import 'dart:convert';
import 'dart:developer';
import 'package:bloc_api/core/note_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://api.nstack.in/v1/todos';

class NotesRepository {
  // Fetch notes from API
  static Future<List<NotesModel>> fetchNotes() async {
    var client = http.Client();
    List<NotesModel> notes = [];

    try {
      var response = await client.get(Uri.parse(baseUrl));
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List notesFromJson = responseData['items'];
        log('items in notes are ${responseData['items']}');
        for (Map<String, dynamic> note in notesFromJson) {
          notes.add(NotesModel.fromMap(note));
        }
      }
      // log('response body ${response.body}');
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
      var response = await client.post(Uri.parse(baseUrl),
          body: jsonEncode(note.toMap()),
          headers: {'Content-Type': 'application/json'});
      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
