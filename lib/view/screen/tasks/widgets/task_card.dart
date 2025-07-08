import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/data/model/task_model.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  String getDueText(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now).inDays;
    if (diff <= 0) return "Tomorrow";
    return "${diff + 1} Days";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${task.priority} Priority",
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Due: ${getDueText(task.dueDate ?? DateTime.now())}",
                  style: TextStyle(color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              task.imageUrl, // 👈 your Cloudinary image URL string
              width: 100,
              height: 70,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: 100,
                  height: 70,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 70,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
