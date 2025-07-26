import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/data/services/auth_services.dart';
import 'package:errandbuddy/view/auth/forgot_password.dart/forgot_password.dart';
import 'package:errandbuddy/view/auth/sign_up/sign_up_screen.dart';
import 'package:errandbuddy/view/role_selection/role_selection_screen.dart';
import 'package:errandbuddy/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../sign_in/sign_in_screen.dart';

class SignStack extends StatelessWidget {
  final bool isSignUp;
  const SignStack({super.key, required this.isSignUp});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final PasswordController passwordController = Get.put(PasswordController());
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.darkTeal,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  isSignUp ? 'Create Your' : 'Welcome Back',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.iconColor,
                  ),
                ),
                Text(
                  isSignUp ? 'Account' : 'Sign In!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.iconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.7,
          maxChildSize: 0.7,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.iconColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isSignUp)
                      TextField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          suffixIcon: Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(Icons.email, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => TextField(
                        controller: passwordCtrl,
                        obscureText: passwordController.isObscure.value,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: passwordController.toggleVisibility,
                            icon: Icon(
                              color: Colors.grey,
                              passwordController.isObscure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    isSignUp
                        ? TextField(
                            controller: confirmCtrl,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                              suffixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.to(() => ForgotPasswordScreen());
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () async {
                        final email = emailCtrl.text.trim();
                        final pass = passwordCtrl.text.trim();
                        final confirm = confirmCtrl.text.trim();

                        if (email.isEmpty || pass.isEmpty) {
                          Get.snackbar("Error", "Email and password required");
                          return;
                        }

                        if (isSignUp) {
                          if (pass != confirm) {
                            Get.snackbar("Error", "Passwords do not match");
                            return;
                          }
                          bool success = await AuthController.instance.signUp(
                            email,
                            pass,
                          );

                          if (success) {
                            Get.to(() => RoleSelectionPage());
                          }
                        } else {
                          // if signIn don't need to go to selection page as he is already in a group so home page
                          final result = await AuthController.instance.signIn(
                            email,
                            pass,
                          );
                          if (result) Get.to(() => HomeScreen());
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.darkTeal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            isSignUp ? 'Create Account' : 'Sign In',
                            style: TextStyle(color: AppColors.backgroundLight),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      isSignUp
                          ? "Already have an account?"
                          : "Don't have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: AppColors.headingText,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        isSignUp
                            ? Get.off(() => SignUpScreen())
                            : Get.off(() => SignInScreen());
                      },
                      child: Text(
                        isSignUp ? "Sign In" : "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
