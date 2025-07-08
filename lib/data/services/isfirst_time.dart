

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String onboardingKey = 'is_first_time';

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? true;
  }

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, false);
  }
}
