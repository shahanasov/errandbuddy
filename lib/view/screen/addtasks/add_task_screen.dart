import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:errandbuddy/controllers/add_task_controllers.dart';
import 'package:errandbuddy/view/screen/addtasks/widgets/custom_input_field.dart';
import 'package:errandbuddy/view/screen/addtasks/widgets/priority_field.dart';
import 'package:errandbuddy/view/screen/addtasks/widgets/toggle_people.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTaskController());
    if (!Get.isRegistered<ImageController>()) {
      Get.put(ImageController());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: Get.back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputField(
                hint: 'Task Title',
                controller: controller.titleController,
              ),
              const SizedBox(height: 12),

              //  add image field
              ImageField(),
              const SizedBox(height: 16),
              const Text(
                "Priority",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: const [
                  PriorityChip(label: 'High'),
                  SizedBox(width: 8),
                  PriorityChip(label: 'Medium'),
                  SizedBox(width: 8),
                  PriorityChip(label: 'Low'),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() {
                  final name = controller.selectedAssigneeName.value;
                  return Text(
                    name.isEmpty ? "Assignee" : "Assignee: $name",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                }),
              ),
              const SizedBox(height: 8),
              AssigneeSelector(),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    controller.setDueDate(picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() {
                    return Text(
                      controller.selectedDate.value != null
                          ? "Due: ${controller.selectedDate.value!.toLocal().toString().split(' ')[0]}"
                          : "Due Date",
                      style: const TextStyle(color: Colors.blueGrey),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: controller.submitTask,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.backgroundLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text("Add Task"),
        ),
      ),
    );
  }
}
