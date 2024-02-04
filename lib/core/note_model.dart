
class NotesModel {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String title;
  final String description;
  final bool? isCompleted;

  NotesModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> json) {
    return NotesModel(
      id: json['_id'] as String,
      createdAt: json['created_at'] != null ? json['created_at'] as String : null,
      updatedAt: json['updated_at'] != null ? json['updated_at'] as String : null,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['is_completed'] != null ? json['is_completed'] as bool : null,
    );
  }

}

