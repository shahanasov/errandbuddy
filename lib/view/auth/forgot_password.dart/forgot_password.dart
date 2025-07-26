import 'package:errandbuddy/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/auth_services.dart';
import '../sign_in/sign_in_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailCtrl = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Text(
                "Forgot\npassword?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.headingText,
                ),
              ),
              const SizedBox(height: 30),
              //  textfield
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.check, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Text(
                      '* ',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.headingText,
                      ),
                    ),
                  ),
                  Text(
                    "We will send you a message to set or reset\n your new password",
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final email = emailCtrl.text.trim();
                  if (email.isEmpty) {
                    Get.snackbar("Error", "Please enter your email");
                    return;
                  }

                  bool success = await AuthController.instance.forgotPassword(
                    email,
                  );
                  if (success) {
                    Get.snackbar("Success", "Reset link sent to your email");
                    Future.delayed(Duration(seconds: 1), () {
                      Get.off(() => SignInScreen()); // Go back to sign in
                    });
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkHeader,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Send Reset Link",
                  style: TextStyle(color: AppColors.backgroundLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
