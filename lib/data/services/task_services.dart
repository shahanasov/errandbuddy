
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/task_model.dart';

Future<void> markTaskAssigned(String name) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('members')
        .where('name', isEqualTo: name)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection('members')
          .doc(docId)
          .update({'assigned': FieldValue.increment(1)});

      
    } else {
      print("No user found with name $name ❌");
    }
  } catch (e) {
    print("Error: $e");
  }
}

void fetchAndUpdateOverdueTasks() async {
  try {
    final now = DateTime.now();

    // Step 1: Fetch all tasks
    final snapshot = await FirebaseFirestore.instance.collection('tasks').get();

    // Step 2: Filter only overdue tasks
    final overdueTasks = snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data()))
        .where((task) => task.dueDate != null && task.dueDate!.isBefore(now))
        .toList();

    // Step 3: Group overdue task count by name
    final Map<String, int> overdueCountByName = {};

    for (var task in overdueTasks) {
      final name = task.assignee; // or task.name based on your model
      if (name != null) {
        overdueCountByName[name] = (overdueCountByName[name] ?? 0) + 1;
      }
    }

    // Step 4: Update 'overdue' field for each member
    for (var entry in overdueCountByName.entries) {
      final name = entry.key;
      final count = entry.value;

      final snapshot = await FirebaseFirestore.instance
          .collection('members')
          .where('name', isEqualTo: name)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('members')
            .doc(docId)
            .update({'overdue': count});

        print("Updated $name's overdue count to $count ✅");
      } else {
        print("No user found with name $name ❌");
      }
    }
  } catch (e) {
    print("Error updating overdue tasks: $e");
  }
}



Future<void> markTaskAsCompleted(TaskModel task) async {
  await FirebaseFirestore.instance.collection('tasks').doc(task.id).update({
    'isCompleted': true,
  });

  // Update the member's completedTasks count
  final memberRef = FirebaseFirestore.instance.collection('members').doc(task.assignee);

  // Firestore transaction to avoid conflict
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final memberSnapshot = await transaction.get(memberRef);
    int currentCount = memberSnapshot['completedTasks'] ?? 0;
    transaction.update(memberRef, {'completedTasks': currentCount + 1});
  });
}
