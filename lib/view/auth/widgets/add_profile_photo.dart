
import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProfilePhoto extends StatelessWidget {
  const AddProfilePhoto({super.key, required this.imageController});

  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await imageController.pickImage();
      },
      child: Obx(() {
        return CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.iconColor,
          backgroundImage: imageController.selectedImage.value != null
              ? FileImage(imageController.selectedImage.value!)
              : null,
          child: imageController.selectedImage.value == null
              ? Icon(
                  Icons.person_add_alt,
                  size: 40,
                  color: AppColors.darkHeader,
                )
              : null,
        );
      }),
    );
  }
}
