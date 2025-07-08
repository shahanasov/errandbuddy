import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
  Get.put(SplashController());


    return Scaffold(
      backgroundColor: AppColors.darkTeal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
           Image.asset('assets/images/splash.png',width: 140,height: 140,),
            SizedBox(height: 20),
            Text(
              'ERRAND BUDDY',
              style: TextStyle(
                color: AppColors.backgroundLight,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
