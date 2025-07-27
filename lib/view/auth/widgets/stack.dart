import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:errandbuddy/controllers/addto_group.dart';
import 'package:errandbuddy/data/services/auth_services.dart';
import 'package:errandbuddy/view/auth/forgot_password.dart/forgot_password.dart';
import 'package:errandbuddy/view/auth/sign_up/sign_up_screen.dart';
import 'package:errandbuddy/view/auth/widgets/add_profile_photo.dart';
import 'package:errandbuddy/view/role_selection/role_selection_screen.dart';
import 'package:errandbuddy/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../sign_in/sign_in_screen.dart';

final userInfoController = Get.put(UserInfoController());
 final ImageController imageController = Get.find<ImageController>();

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
        buildTopSection(isSignUp, imageController),
        buildFormSheet(
          isSignUp,
          nameCtrl,
          emailCtrl,
          passwordCtrl,
          confirmCtrl,
          passwordController,
        ),
      ],
    );
  }

  Widget buildTopSection(bool isSignUp, ImageController imageController) {
    return Container(
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
            const SizedBox(height: 10),
            if (isSignUp)
              Center(child: AddProfilePhoto(imageController: imageController)),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix ?? Icon(icon, color: Colors.grey),
      ),
    );
  }

  Widget buildFormSheet(
    bool isSignUp,
    TextEditingController nameCtrl,
    TextEditingController emailCtrl,
    TextEditingController passwordCtrl,
    TextEditingController confirmCtrl,
    PasswordController passwordController,
  ) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.7,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.iconColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (isSignUp)
                  buildTextField(
                    controller: nameCtrl,
                    hint: 'Name',
                    icon: Icons.person,
                  ),
                const SizedBox(height: 10),
                buildTextField(
                  controller: emailCtrl,
                  hint: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => buildTextField(
                    controller: passwordCtrl,
                    hint: 'Password',
                    obscure: passwordController.isObscure.value,
                    icon: Icons.lock,
                    suffix: IconButton(
                      onPressed: passwordController.toggleVisibility,
                      icon: Icon(
                        passwordController.isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                isSignUp
                    ? buildTextField(
                        controller: confirmCtrl,
                        hint: 'Confirm Password',
                        icon: Icons.lock_outline,
                        obscure: true,
                      )
                    : GestureDetector(
                        onTap: () => Get.to(() => ForgotPasswordScreen()),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                const SizedBox(height: 30),
                buildSubmitButton(
                  isSignUp,
                  imageController.selectedImage.value?.path ?? "",
                  nameCtrl,
                  emailCtrl,
                  passwordCtrl,
                  confirmCtrl,
                ),
                const Spacer(),
                buildSwitchAuth(isSignUp),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSubmitButton(
    bool isSignUp,
    String selectedImagePath,
    TextEditingController nameCtrl,
    TextEditingController emailCtrl,
    TextEditingController passwordCtrl,
    TextEditingController confirmCtrl,
  ) {
    return InkWell(
      onTap: () async {
        final email = emailCtrl.text.trim();
        final pass = passwordCtrl.text.trim();
        final confirm = confirmCtrl.text.trim();
        final name = nameCtrl.text.trim();

        if (email.isEmpty || pass.isEmpty) {
          Get.snackbar("Error", "Email and password required");
          return;
        }

        if (isSignUp) {
          if (pass != confirm) {
            Get.snackbar("Error", "Passwords do not match");
            return;
          }
          bool success = await AuthController.instance.signUp(email, pass);
          // passing name and image to nextpage to save in firebase under group
          userInfoController.setUserInfo(name, selectedImagePath);
          if (success) Get.to(() => RoleSelectionPage());
        } else {
          final result = await AuthController.instance.signIn(email, pass);
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
    );
  }

  Widget buildSwitchAuth(bool isSignUp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isSignUp ? "Already have an account?" : "Don't have an account?",
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
    );
  }
}
