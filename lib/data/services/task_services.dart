import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/task_model.dart';

Future<void> saveTask(TaskModel task) async {
  try {
    // Get a reference to the Firestore collection "tasks"
    final taskCollection = FirebaseFirestore.instance.collection('tasks');

    // Convert the task to a JSON-like map
    final taskData = task.toJson();

    // Add the task to Firestore (auto-generates an ID)
    await taskCollection.add(taskData);

    // print('✅ Task saved successfully!');
  } catch (e) {
    // print('❌ Failed to save task: $e');
  }
}
