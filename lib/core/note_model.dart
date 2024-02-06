
class NotesModel {
  late String? id;
  final int? createdAt;
  final int? updatedAt;
  final String title;
  final String description;
  final bool? isCompleted;

  NotesModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // '_id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> json) {
    return NotesModel(
      id: json['_id'] as String,
      createdAt: json['createdAt'] != null ? json['createdAt'] as int : null,
      updatedAt: json['updated_at'] != null ? json['updated_at'] as int : null,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] != null ? json['isCompleted'] as bool : null,
    );
  }

}

