import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/task_model.dart';
import 'package:get/get.dart';

class TaskListController extends GetxController {
  final tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

void fetchTasks() {
  FirebaseFirestore.instance.collection('tasks').snapshots().listen((snapshot) {
    final now = DateTime.now();
    final nonOverdueTasks = snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data()))
        .where((task) => task.dueDate == null || task.dueDate!.isAfter(now))
        .toList();

    tasks.assignAll(nonOverdueTasks);
  });
}

}
