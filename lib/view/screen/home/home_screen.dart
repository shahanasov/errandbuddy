import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/bottom_nav.dart';
import 'package:errandbuddy/view/screen/escalation/escalation_screen.dart';
import 'package:errandbuddy/view/screen/members/members_screen.dart';
import 'package:errandbuddy/view/screen/tasks/task_screen.dart';
import 'package:errandbuddy/view/widgets/all_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController navController = Get.put(BottomNavController());

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: navController.currentIndex.value,
          children: const [MembersTab(),TaskTab(), EscalationLogScreen(), ProfileTab()],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.secondaryText, width: 1),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: navController.currentIndex.value,
            onTap: navController.changeIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.darkTeal,
            unselectedItemColor: AppColors.secondaryText,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Members',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Escalations',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: 'profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
