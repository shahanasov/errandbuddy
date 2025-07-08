class TaskModel {
  String title;
  String description;
  String priority;
  String assignee;
  DateTime? dueDate;

  TaskModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.assignee,
    this.dueDate,
  });

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: map['priority'] ?? '',
       assignee:map['assignee'], 
      dueDate: map['dueDate'] != null ? DateTime.tryParse(map['dueDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'assignee': assignee,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
