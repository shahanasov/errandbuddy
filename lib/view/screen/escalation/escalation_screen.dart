import 'package:errandbuddy/controllers/escalation_controller.dart';
import 'package:errandbuddy/view/screen/escalation/widgets/escalation_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EscalationLogScreen extends StatelessWidget {
  const EscalationLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EscalationLogController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Escalation Log", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
         if (controller.tasks.isEmpty) {
          return const Center(
            child: Text(
              "No escalated tasks!",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Escalated Tasks",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.tasks.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    return EscalationTaskTile(task: controller.tasks[index]);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
