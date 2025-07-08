import 'package:errandbuddy/constants/colors.dart';
import 'package:errandbuddy/controllers/add_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  const CustomInputField({
    super.key,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}

class ImageField extends StatelessWidget {
  const ImageField({super.key});

  @override
  Widget build(BuildContext context) {
    
    final ImageController imageController = Get.find<ImageController>();

    return GestureDetector(
      onTap: () {
        imageController.pickImage();
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
              ? Image.file(
                  imageController.selectedImage.value!,
                  fit: BoxFit.fill,
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
