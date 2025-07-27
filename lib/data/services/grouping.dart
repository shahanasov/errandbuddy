import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/members_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

Future<void> handleGroupJoinOrCreate({
  required String groupId,
  required String name,
  required String role, 
  required String imageUrl,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final groupRef = FirebaseFirestore.instance.collection('groups').doc(groupId);
  final memberRef = groupRef.collection('members').doc(uid);

  try {
    final groupSnapshot = await groupRef.get();

    if (role == 'leader') {
      // 🔹 If group already exists, don't allow leader to use same ID
      if (groupSnapshot.exists) {
        print('❌ Group already exists');
        Get.snackbar("Group Exists", "This group ID is already taken.");
        return;
      }

      // 🔹 Create new group
      await groupRef.set({
        'createdBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      // 🔹 For members, group must already exist
      if (!groupSnapshot.exists) {
        print('❌ Group does not exist');
        Get.snackbar("Group Not Found", "Please check the group code.");
        return;
      }
    }

    // 🔹 Create member object
    final member = MembersModel(
      name: name,
      assigned: 0,
      overdue: 0,
      completed: 0,
      imageUrl: imageUrl,
      id: uid,
      groupId: groupId,
    );

    // 🔹 Save member to group
    await memberRef.set(member.toJson());

    print('✅ User added to group successfully');
  } catch (e) {
    print('❌ Error while adding to group: $e');
    Get.snackbar("Error", "Something went wrong.");
  }
}


// Future<void> joinGroup({
//   required BuildContext context,
//   required String groupId,
//   required String name,
//   required String imageUrl,
// }) async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (_) => const Center(child: CircularProgressIndicator()),
//   );

//   try {
//     DocumentSnapshot groupDoc =
//         await firestore.collection('groups').doc(groupId).get();

//     if (!groupDoc.exists) {
//       Navigator.of(context).pop(); // Remove loading
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Group ID doesn't exist")),
//       );
//       return;
//     }

//     await firestore
//         .collection('groups')
//         .doc(groupId)
//         .collection('members')
//         .doc(userId)
//         .set({
//       'name': name,
//       'imageUrl': imageUrl,
//       'joinedAt': FieldValue.serverTimestamp(),
//     });

//     Navigator.of(context).pop(); // Remove loading
//     Navigator.of(context).pushReplacementNamed('/home'); // Navigate to home
//   } catch (e) {
//     Navigator.of(context).pop(); // Remove loading
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error joining group: $e")),
//     );
//   }
// }

