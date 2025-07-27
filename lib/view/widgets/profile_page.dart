import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/data/services/auth_services.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.darkTeal,
            child: Image.network(
              "https://image.winudfcom",
              fit: BoxFit.cover,
              loadingBuilder:
                  (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child; // Image is fully loaded
                    }

                    // Show CircularProgressIndicator while loading
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        color: Colors.white,
                      ),
                    );
                  },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                    // Show an error icon or a custom message
                    return Image.asset(
                      "assets/images/girl.png",
                      fit: BoxFit.cover,
                    );
                  },
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.6,
            builder: (context, controller) {
              return Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.iconColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Center(child: Text('Name')),
                    Center(child: Text('Emailid')),
                    SizedBox(height: 15),
                    Card(
                      color: AppColors.cardColor,
                      child: ListTile(title: Text('Assigned : count')),
                    ),
                    Card(
                      color: AppColors.cardColor,
                      child: ListTile(title: Text('Completed : count')),
                    ),
                    Card(
                      color: AppColors.cardColor,
                      child: ListTile(title: Text('Overdue : count')),
                    ),
                    Card(
                      color: AppColors.cardColor,
                      child: ListTile(
                        title: Text('Log out'),
                        leading: IconButton(
                          icon: const Icon(Icons.login, color: Colors.black),
                          onPressed: () async {
                            await AuthController.instance.signOutUser();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
