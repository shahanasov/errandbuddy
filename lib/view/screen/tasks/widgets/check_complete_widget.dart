import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/data/model/task_model.dart';
import 'package:errandbuddy/data/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

isCompleted(BuildContext context, TaskModel task,bool isOverdue) {

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.darkTeal,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                "Mark as Completed?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Are you sure you want to mark this task as completed?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkTeal,
                      foregroundColor: AppColors.backgroundLight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(task.id)
                          .update({'isCompleted': true});
                          countCompletedTask(task,isOverdue: isOverdue);
                      Get.snackbar("✅ Completed", "Task marked as completed");
                    },
                    child: const Text("Yes"),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}


