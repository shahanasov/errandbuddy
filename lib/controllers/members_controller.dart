import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errandbuddy/data/model/members_model.dart';
import 'package:get/get.dart';

class AssigneeSummaryController extends GetxController {
  final assignees = <Assignee>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssigneeStats();
  }

  void fetchAssigneeStats() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('members')
        .get();
    final data = snapshot.docs.map((e) => Assignee.fromMap(e.data())).toList();
    assignees.assignAll(data);
  }
}
