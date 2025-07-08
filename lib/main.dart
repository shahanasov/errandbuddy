import 'package:errandbuddy/constants/theme.dart';
import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:errandbuddy/data/services/task_services.dart';
import 'package:errandbuddy/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:errandbuddy/view/screen/onboarding_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ImageController()); 
  fetchAndUpdateOverdueTasks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ERRAND BUDDY',
      theme: AppTheme.light,
      home: SplashScreen(),
    );
  }
}
