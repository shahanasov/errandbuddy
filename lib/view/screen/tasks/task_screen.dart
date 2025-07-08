import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/task_list_controller.dart';
import 'package:errandbuddy/view/screen/addtasks/add_task_screen.dart';
import 'package:errandbuddy/view/screen/tasks/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskTab extends StatelessWidget {
  const TaskTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskListController());
    return Scaffold(
      appBar: AppBar(title: Text('Task'), centerTitle: true),
          body: Obx(() {
        if (controller.tasks.isEmpty) {
          return const Center(child: Text("No tasks yet!"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.tasks.length,
          itemBuilder: (_, index) {
            return TaskCard(task: controller.tasks[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blue[200],
        onPressed: () {
          Get.to(() => const AddTaskScreen());
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(Icons.add, color: AppColors.cardColor, size: 30),
      ),

  
    );
  }
}
