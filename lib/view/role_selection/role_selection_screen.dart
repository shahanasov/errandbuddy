import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/view/role_selection/widgets/create_group.dart';
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            const Text(
              "Choose your role",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            const Text(
              "which role suites you best",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 40),
            // Leader button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 10,
              children: [
                roleContainer(isLeader: true, context: context),
                // Member button
                roleContainer(isLeader: false, context: context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell roleContainer({
    required bool isLeader,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        isLeader
            ? showJoinInfoDialog(context) //here add a showdialogue
            : showPasteIdDialog(context);
      },
      child: Container(
        height: 180,
        width: 150,

        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          spacing: 15,

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.backgroundLight,
              radius: 30,
              child: Image.asset(
                isLeader
                    ? 'assets/images/leader.png'
                    : 'assets/images/user.png',
                height: 35,
              ),
            ),
            Text(isLeader ? 'Create a Group' : 'Join a Group'),
          ],
        ),
      ),
    );
  }
}
