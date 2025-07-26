import 'dart:math';

import 'package:flutter/material.dart';
import 'package:errandbuddy/constants/colors.dart';
import 'package:flutter/services.dart';

void showPasteIdDialog(BuildContext context) {
  TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Paste ID to Join the Group",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "Paste the group ID you received below and tap Join to continue.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter or paste group ID",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.paste),
                    onPressed: () async {
                      ClipboardData? data = await Clipboard.getData(
                        'text/plain',
                      );
                      if (data != null) {
                        controller.text = data.text ?? '';
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text("Pasted from clipboard")),
                        // );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  String meetingId = controller.text.trim();
                  if (meetingId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a group ID")),
                    );
                  } else {
                    Navigator.of(context).pop(); // Close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Joining: $meetingId")),
                    );
                    // You can call your join logic here using meetingId
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.darkTeal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: const Text(
                      "Join",
                      style: TextStyle(color: AppColors.backgroundLight),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

String generateGroupCode() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return List.generate(
    6,
    (index) => chars[Random().nextInt(chars.length)],
  ).join();
}

// based on date to make it unique
// String generateGroupCode() {
//   final now = DateTime.now();
//   final formatter = DateFormat('MMddHH'); // MM = month, dd = day, HH = hour
//   String datePart = formatter.format(now); // e.g. 071915 (July 19, 3pm)

//   const prefix = ['GRP', 'FLTR', 'TM']; // You can rotate or fix
//   String prefixPart = prefix[Random().nextInt(prefix.length)];

//   return '$prefixPart$datePart'; // Example: FLTR071915
// }

void showJoinInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final String meetingId = generateGroupCode();
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Here's your Group ID",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Send this to people you want to join with.", //\nBe sure to save it so you can use it later, too.
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Container(
               padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      meetingId,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: meetingId));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Link copied to clipboard"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  if (meetingId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a group ID")),
                    );
                  } else {
                    Navigator.of(context).pop(); // Close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Joining: $meetingId")),
                    );
                    // You can call your join logic here using meetingId
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.darkTeal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: const Text(
                      "Join",
                      style: TextStyle(color: AppColors.backgroundLight),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
