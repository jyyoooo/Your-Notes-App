// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotesModel {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String title;
  final String description;
  final bool? isCompleted;

  NotesModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });
}





// [
//   {
//     "_id": "string",
//     "created_at": "2024-02-04T05:37:16.353Z",
//     "updated_at": "2024-02-04T05:37:16.353Z",
//     "title": "string",
//     "description": "string",
//     "is_completed": true
//   }
// ]