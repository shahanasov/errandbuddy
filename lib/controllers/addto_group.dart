import 'package:get/get.dart';

class UserInfoController extends GetxController {
  RxString name = ''.obs;
  RxString imagePath = ''.obs; // path of local image

  void setUserInfo(String userName, String userImagePath) {
    name.value = userName;
    imagePath.value = userImagePath;
  }
}


