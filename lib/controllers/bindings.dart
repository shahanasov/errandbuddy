import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:get/get.dart';
import 'package:errandbuddy/data/services/auth_services.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put(ImageController());
  }
}
