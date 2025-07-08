class TaskModel {
  String title;
  String priority;
  String assignee;
  DateTime? dueDate;
  String imageUrl;
  String? id;
  bool isCompleted;
  TaskModel({
    required this.title,
    required this.priority,
    required this.assignee,
    required this.imageUrl,
    required this.isCompleted,
    this.dueDate,
    this.id,
  });

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] ?? '',
      priority: map['priority'] ?? '',
      assignee: map['assignee'],
      dueDate: map['dueDate'] != null
          ? DateTime.tryParse(map['dueDate'])
          : null,
      imageUrl: map['imageUrl'] ?? '',
      id: map['id'] ?? '',
      isCompleted: map['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isCompleted': isCompleted,
      'title': title,
      'priority': priority,
      'assignee': assignee,
      'dueDate': dueDate?.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}
