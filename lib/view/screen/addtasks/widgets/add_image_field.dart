import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageField extends StatelessWidget {
  const ImageField({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.find<ImageController>();

    return GestureDetector(
      onTap: () async {
        await imageController.pickImage();
        print("Picked Image: ${imageController.selectedImage.value?.path}");
      },
      child: Obx(() {
        return Container(
          decoration: BoxDecoration(
            border: BoxBorder.all(color: AppColors.headingText),
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 144,
          child: imageController.selectedImage.value != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.file(
                    imageController.selectedImage.value!,
                    fit: BoxFit.fill,
                  ),
                )
              : Center(
                  child: Text(
                    'Add image',
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                ),
        );
      }),
    );
  }
}
