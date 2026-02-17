class TaskEntityModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  TaskEntityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  factory TaskEntityModel.fromJson(Map<String, dynamic> json) {
    return TaskEntityModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'],
      createdAt: DateTime.parse(json['created_At']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
      'created_At': createdAt.toIso8601String(),
    };
  }

  TaskEntityModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TaskEntityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
