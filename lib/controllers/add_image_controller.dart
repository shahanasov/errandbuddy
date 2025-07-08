import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

Future<void> pickImage() async {
  final XFile? image = await picker.pickImage(source: ImageSource.gallery); 
  if (image != null) {
    selectedImage.value = File(image.path);
  } else {
    Get.snackbar("No Image", "No image selected");
  }
}



  // Step 2: Upload image to Cloudinary and return the secure URL
  Future<String?> uploadImageToCloudinary() async {
    if (selectedImage.value == null) {
      Get.snackbar("No Image", "Please select an image first");
      return null;
    }

    try {
      final cloudinaryUrl = "https://api.cloudinary.com/v1_1/dahbtbonq/image/upload";

      final request = http.MultipartRequest("POST", Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = "errandbuddy"
        ..fields['folder'] = "task"
        ..files.add(
          await http.MultipartFile.fromPath('file', selectedImage.value!.path),
        );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        final data = jsonDecode(responseBody.body);
        final imageUrl = data['secure_url'];

        Get.snackbar("Success", "Image uploaded successfully");
        return imageUrl;
      } else {
        Get.snackbar("Upload Failed", "Cloudinary error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
      return null;
    }
  }
}






