import 'package:errandbuddy/data/model/members_model.dart';
import 'package:flutter/material.dart';

class AssigneeSummaryCard extends StatelessWidget {
  final MembersModel assignee;

  const AssigneeSummaryCard({super.key, required this.assignee});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(assignee.imageUrl),
            radius: 30,
          ),
          const SizedBox(height: 8),
          Text(
            assignee.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text("Assigned: ${assignee.assigned}"),
          Text("Overdue: ${assignee.overdue}"),
          Text("Completed: ${assignee.completed}"),
        ],
      ),
    );
  }
}
