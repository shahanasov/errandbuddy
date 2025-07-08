import 'package:errandbuddy/controllers/members_controller.dart';
import 'package:errandbuddy/view/screen/members/widgets/member_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssigneeSummaryController());

    return Scaffold(
      appBar: AppBar(title: const Text("Members"), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value==true) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.assignees.isEmpty) {
          Center(child: Text('No Members yet!'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.assignees.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (_, index) {
            final assignee = controller.assignees[index];
            return AssigneeSummaryCard(assignee: assignee);
          },
        );
      }),
    );
  }
}
