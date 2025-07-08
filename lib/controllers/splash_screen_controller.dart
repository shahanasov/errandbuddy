import 'package:errandbuddy/data/services/isfirst_time.dart';
import 'package:errandbuddy/view/screen/home/home_screen.dart';
import 'package:errandbuddy/view/screen/onboarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';

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
      Get.off(() => const OnboardingScreen());
    } else {
      Get.off(() => const HomeScreen());
    }
  }
}
