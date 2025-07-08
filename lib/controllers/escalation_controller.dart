import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/task_model.dart';
import 'package:get/get.dart';

class EscalationLogController extends GetxController {
  final tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEscalatedTasks();
  }

  void fetchEscalatedTasks() async {
    final now = DateTime.now();
    FirebaseFirestore.instance.collection('tasks').snapshots().listen((
      snapshot,
    ) {
      final escalated = snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data()))
          .where(
            (task) =>
                task.dueDate != null &&
                task.dueDate!.isBefore(now) &&
                task.isCompleted == false,
          )
          .toList();

      tasks.assignAll(escalated);
    });
  }
}
