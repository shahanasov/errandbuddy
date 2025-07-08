class Assignee {
  final String name;
  final int assigned;
  final int overdue;
  final int completed;
  final String imageUrl;
  final String id;

  Assignee({
    required this.name,
    required this.assigned,
    required this.overdue,
    required this.completed,
    required this.imageUrl,
    required this.id
  });

  static Assignee fromMap(Map<String, dynamic> map) {
    return Assignee(
      name: map['name'] ?? '',
      assigned: map['assigned'] ?? 0,
      overdue: map['overdue'] ?? 0,
      completed: map['completed'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      id:map['id']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'assigned': assigned,
      'overdue': overdue,
      'completed': completed,
      'imageUrl': imageUrl,
      'id':id
    };
  }
}
