import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColors.darkTeal,
      pages: [
        PageViewModel(
          title: "Manage Your Tasks",
          body: "Easily create, edit,\n and complete your daily tasks.",
          image: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Image.asset("assets/images/todo.png", height: 300),
          ),
          decoration: customPageDecoration,
        ),
        PageViewModel(
          title: "Organize Your Life",
          body: "Group your tasks\n and stay organized without effort.",
          image: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(15),
            child: Image.asset("assets/images/todo.png", height: 300),
          ),
          decoration: customPageDecoration,
        ),
        PageViewModel(
          title: "Get Reminded",
          body: "Never miss a task with\n timely notifications and reminders.",
          image: Image.asset("assets/images/todo.png", height: 300),
          decoration: customPageDecoration,
        ),
      ],

      dotsDecorator: DotsDecorator(
        size: const Size(8.0, 8.0),
        activeSize: const Size(24.0, 8.0),
        activeColor: AppColors.iconColor,
        color: AppColors.headingText,
        spacing: const EdgeInsets.symmetric(horizontal: 4),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),

     
      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.cardColor,
        ),
      ),

      showNextButton: false,
      done: const Text(
        "Get Started",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.cardColor,
        ),
      ),
      onDone: () {
        Get.off(() => const HomeScreen());
      },
    );
  }
}

final PageDecoration customPageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.iconColor,
  ),
  bodyTextStyle: TextStyle(fontSize: 16, color: AppColors.iconColor),
  contentMargin: EdgeInsets.symmetric(horizontal: 16),
  imagePadding: EdgeInsets.zero,
  titlePadding: EdgeInsets.only(top: 4, bottom: 5),
  bodyPadding: EdgeInsets.only(bottom: 4, top: 6),
  imageAlignment: Alignment.bottomCenter,
  bodyAlignment: Alignment.topCenter,
  imageFlex: 2,
  bodyFlex: 1,
);
