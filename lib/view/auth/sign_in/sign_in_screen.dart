import 'package:errandbuddy/view/auth/widgets/stack.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // form
      body: SignStack(isSignUp: true,),
    );
  }
}