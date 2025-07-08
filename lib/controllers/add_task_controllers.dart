import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:errandbuddy/data/services/task_services.dart';
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
  // 💡 Step 1: Add image controller
  final imageController = Get.find<ImageController>();

  // 🛑 Step 2: Validation (added image check)
  if (titleController.text.trim().isEmpty ||
      descriptionController.text.trim().isEmpty ||
      selectedPriority.value.isEmpty ||
      selectedAssignee.value.isEmpty ||
      imageController.selectedImage.value == null) {
    Get.snackbar("Validation", "All fields are required including an image.");
    return;
  }

  try {
    // ☁️ Step 3: Upload image to Cloudinary
    final imageUrl = await imageController.uploadImageToCloudinary();
    if (imageUrl == null) {
      Get.snackbar("Image Error", "Failed to upload image.");
      return;
    }

    // 📦 Step 4: Create task model with imageUrl
    final newTask = TaskModel(
      title: titleController.text.trim(),
      priority: selectedPriority.value,
      assignee: selectedAssigneeName.string,
      dueDate: selectedDate.value,
      description: imageUrl, // ✅ HIGHLIGHTED: Add this line in your model too
    );

    // ✅ Step 5: Assign task to assignee
    markTaskAssigned(selectedAssigneeName.string);

    // 🔥 Step 6: Add to Firestore
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
