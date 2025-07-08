
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/task_model.dart';
import 'package:get/get.dart';

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
      // print("No user found with name $name ❌");
    }
  } catch (e) {
    // print("Error: $e");
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
      final name = task.assignee; 
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

        log("Updated $name's overdue count to $count ✅");
      } else {
        log("No user found with name $name ❌");
      }
    }
  } catch (e) {
    log("Error updating overdue tasks: $e");
  }
}
Future<void> countCompletedTask(TaskModel task, {required bool isOverdue}) async {
  try {
    // Look up the member by name (slow)
    final query = await FirebaseFirestore.instance
        .collection('members')
        .where('name', isEqualTo: task.assignee)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      log("❌ No member found with name ${task.assignee}");
      return;
    }

    final memberDoc = query.docs.first;
    final memberRef = memberDoc.reference;

    final data = memberDoc.data();
    int completed = data['completed'] ?? 0;
    int overdue = data['overdue'] ?? 0;
    int assigned = data['assigned'] ?? 0;

    completed += 1;
    if (isOverdue) {
      overdue = overdue > 0 ? overdue - 1 : 0;
    } else {
      assigned = assigned > 0 ? assigned - 1 : 0;
    }

    await memberRef.update({
      'completed': completed,
      'overdue': overdue,
      'assigned': assigned,
    });

    // mark task completed
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(task.id)
        .update({'isCompleted': true});

    Get.snackbar("✅ Task Completed", "Member stats updated");
  } catch (e) {
    log("❌ Error: $e");
    Get.snackbar("Error", "Could not update member stats");
  }
}
