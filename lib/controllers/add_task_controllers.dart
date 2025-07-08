import 'dart:developer';

import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:errandbuddy/data/services/task_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/task_model.dart';

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final selectedPriority = ''.obs;
  final selectedDate = Rxn<DateTime>();
  final selectedAssignee = ''.obs;
  final selectedAssigneeName = ''.obs;
  final isLoading = false.obs;

  void selectPriority(String priority) {
    selectedPriority.value = priority;
  }

  void setDueDate(DateTime date) {
    selectedDate.value = date;
  }

  void toggleAssignee(String id, String name) {
    if (selectedAssignee.value == id) {
      selectedAssignee.value = '';
      selectedAssigneeName.value = '';
    } else {
      selectedAssignee.value = id;
      selectedAssigneeName.value = name;
    }
  }



  Future<void> submitTask() async {
    log("📌 submitTask started");

    final imageController = Get.find<ImageController>();

    if (titleController.text.trim().isEmpty ||
        selectedPriority.value.isEmpty ||
        selectedAssignee.value.isEmpty ||
        imageController.selectedImage.value == null) {
      Get.snackbar("Validation", "All fields are required including an image.");
      return;
    }

    isLoading.value = true; // ⏳ Start loading

    try {
      String? imageUrl;

      if (imageController.selectedImage.value != null) {
        imageUrl = await imageController.uploadImageToCloudinary(
          imageController.selectedImage.value!.path,
        );
      } else {
        Get.snackbar("Error", "No image selected to upload");
        return;
      }

      log("✅ Image uploaded: $imageUrl");

      if (imageUrl == null) {
        Get.snackbar("Image Error", "Failed to upload image.");
        return;
      }
      final id = FirebaseFirestore.instance.collection('tasks').doc().id;
      final newTask = TaskModel(
        title: titleController.text.trim(),
        priority: selectedPriority.value,
        assignee: selectedAssigneeName.string,
        dueDate: selectedDate.value,
        imageUrl: imageUrl,
        isCompleted: false,
        id: id
      );
      markTaskAssigned(selectedAssigneeName.string);

      await FirebaseFirestore.instance
          .collection('tasks').doc(id)
          .set(newTask.toJson());

      Get.back();
      Get.snackbar("Success", "Task created successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to create task: $e");
    } finally {
      isLoading.value = false; // Stop loading
      imageController.selectedImage.value = null;
    }
  }
}
