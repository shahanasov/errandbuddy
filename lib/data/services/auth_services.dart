import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> signUp(String email, String password) async {
  try {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    Get.snackbar('Success', 'Account created successfully');
    return true;
  } on FirebaseAuthException catch (e) {
    String message;
    switch (e.code) {
      case 'email-already-in-use':
        message = 'This email is already registered. Try logging in.';
        break;
      case 'invalid-email':
        message = 'Please enter a valid email address.';
        break;
      case 'weak-password':
        message = 'Your password is too weak. Please use at least 6 characters.';
        break;
      case 'operation-not-allowed':
        message = 'Email/password accounts are not enabled.';
        break;
      default:
        message = 'An unknown error occurred. Please try again.';
    }

    Get.snackbar('Sign Up Failed', message);
    return false;
  } catch (e) {
    Get.snackbar('Error', 'Something went wrong. Please try again later.');
    return false;
  }
}


  // In AuthController
  Future<bool> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Reset link sent to your email');
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }
}

class PasswordController extends GetxController {
  var isObscure = true.obs;

  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }
}
