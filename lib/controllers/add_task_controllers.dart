import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/task_model.dart';

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final selectedPriority = ''.obs;
  final selectedDate = Rxn<DateTime>();
  final selectedAssignee = ''.obs;
  final selectedAssigneeName = ''.obs;

  void selectPriority(String priority) {
    selectedPriority.value = priority;
  }

  void setDueDate(DateTime date) {
    selectedDate.value = date;
  }

  void toggleAssignee(String id, String name) {
    if (selectedAssignee.value == id) {
      // Unselect if already selected
      selectedAssignee.value = '';
      selectedAssigneeName.value = '';
    } else {
      // Select the new person
      selectedAssignee.value = id;
      selectedAssigneeName.value = name;
    }
  }

  Future<void> submitTask() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        selectedPriority.value.isEmpty ||
        selectedAssignee.value.isEmpty) {
      Get.snackbar("Validation", "All fields are required.");
      return;
    }

    final newTask = TaskModel(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      priority: selectedPriority.value,
      assignee: selectedAssigneeName.string,
      dueDate: selectedDate.value,
    );

    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .add(newTask.toJson());

      Get.back();
      Get.snackbar("Success", "Task created successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to create task: $e");
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
