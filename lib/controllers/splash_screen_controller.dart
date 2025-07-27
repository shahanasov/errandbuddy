import 'package:errandbuddy/data/services/isfirst_time.dart';
import 'package:errandbuddy/view/auth/sign_up/sign_up_screen.dart';
import 'package:errandbuddy/view/screen/home/home_screen.dart';
import 'package:errandbuddy/view/screen/onboarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashController extends GetxController {
  static const onboardingKey = 'is_first_time';

  @override
  void onInit() {
    super.onInit();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    final isFirstTime = await AppPreferences().isFirstTime();

    if (isFirstTime) {
      // Show onboarding screen on first install
      Get.off(() => const OnboardingScreen());
    } else {
      // Check if user is logged in
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Get.off(() => const HomeScreen()); // User is signed in
      } else {
        Get.off(() => const SignUpScreen()); // User not signed in
      }
    }
  }
}
