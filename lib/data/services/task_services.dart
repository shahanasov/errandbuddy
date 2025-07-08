
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> markTaskAssigned(String name) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('members')
        .where('name', isEqualTo: name)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection('members')
          .doc(docId)
          .update({'assigned': FieldValue.increment(1)});

      print("Marked $name as completed ✅");
    } else {
      print("No user found with name $name ❌");
    }
  } catch (e) {
    print("Error: $e");
  }
}

