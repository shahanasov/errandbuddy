import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/add_task_controllers.dart';
import 'package:errandbuddy/controllers/members_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssigneeSelector extends StatelessWidget {
  const AssigneeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final member = Get.find<AssigneeSummaryController>();

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: member.assignees.asMap().entries.map((entry) {
          final index = entry.key;
          final user = entry.value;
          return AssigneeAvatar(
            index: index,
            id: user.id,
            name: user.name,
            imagePath: user.imageUrl,
          );
        }).toList(),
      );
    });
  }
}

class AssigneeAvatar extends StatelessWidget {
  final String id;
  final String imagePath;
  final String name;
  final int index;
  final double overlap;

  const AssigneeAvatar({
    super.key,
    required this.id,
    required this.name,
    required this.imagePath,
    required this.index,
    this.overlap = 20,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTaskController>();

    return Obx(() {
      final isSelected = controller.selectedAssignee.contains(id);
      return GestureDetector(
        onTap: () => controller.toggleAssignee(id, name),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Transform.translate(
            offset: Offset(-index * overlap, 0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primaryColor : AppColors.backgroundLight,
                  width: isSelected? 2:5,
                ),
              ),
              child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
            ),
          ),
        ),
      );
    });
  }
}
