import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/add_task_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriorityChip extends StatelessWidget {
  final String label;
  const PriorityChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTaskController>();

    return Obx(() {
      final isSelected = controller.selectedPriority.value == label;
      return ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => controller.selectPriority(label),
        selectedColor: AppColors.primaryColor,
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.backgroundLight : Colors.black,
        ),
      );
    });
  }
}
