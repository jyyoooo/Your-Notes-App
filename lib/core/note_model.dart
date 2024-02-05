
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
    this.isCompleted = false,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'createdAt': createdAt,
      'updated_at': updatedAt,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> json) {
    return NotesModel(
      id: json['_id'] as String,
      createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
      updatedAt: json['updated_at'] != null ? json['updated_at'] as String : null,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] != null ? json['isCompleted'] as bool : null,
    );
  }

}

