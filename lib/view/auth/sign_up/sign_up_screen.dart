
import 'package:errandbuddy/data/services/auth_services.dart';
import 'package:errandbuddy/view/auth/widgets/stack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Get.put(AuthController());
    return Scaffold(
      // form
      body:SignStack(isSignUp: false,),
    );
  }
}
