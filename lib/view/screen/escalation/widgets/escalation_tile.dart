import 'package:errandbuddy/data/model/task_model.dart';
import 'package:errandbuddy/view/screen/tasks/widgets/check_complete_widget.dart';
import 'package:flutter/material.dart';

class EscalationTaskTile extends StatelessWidget {
  final TaskModel task;

  const EscalationTaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    String formatOverdueMessage(DateTime dueDate) {
      final now = DateTime.now();
      final difference = dueDate.difference(now);

      if (difference.isNegative) {
        final overdueHours = difference.inHours.abs();
        return "Overdue by $overdueHours hour${overdueHours == 1 ? '' : 's'}";
      } else {
        final remainingHours = difference.inHours;
        return "overdue by $remainingHours hour${remainingHours == 1 ? '' : 's'}";
      }
    }

    final overdue = formatOverdueMessage(task.dueDate ?? DateTime.now());
    final assigned = task.assignee;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: () {
          isCompleted(context, task,true);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  overflow: TextOverflow.ellipsis,
                  "Originally assigned to $assigned",
                  style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 13),
                ),
              ],
            ),
        
            Text(
              overdue,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
