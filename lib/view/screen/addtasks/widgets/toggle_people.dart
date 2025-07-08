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
        children: member.assignees.map((user) {
          return AssigneeAvatar(
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

  const AssigneeAvatar({
    super.key,
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTaskController>();

    return Obx(() {
      final isSelected = controller.selectedAssignee.contains(id);
      return GestureDetector(
        onTap: () => controller.toggleAssignee(id,name),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
      );
    });
  }
}



//  Obx(() {
//                 return Row(
//                   children: [
//                     for (final user in ['👩‍💼', '🧑‍💼', '👨‍💼']) // emoji placeholders
//                       GestureDetector(
//                         onTap: () => controller.toggleAssignee(user),
//                         child: Container(
                          
//                           padding: const EdgeInsets.all(2),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: controller.selectedAssignees.contains(user)
//                                   ? Colors.blue
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                           ),
//                           child: CircleAvatar(
//                             backgroundColor: Colors.grey.shade300,
//                             child: Text(user),
//                           ),
//                         ),
//                       ),
//                   ],
//                 );
//               }),there should be 2 or more persons  also design should be same 
