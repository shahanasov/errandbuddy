import 'dart:convert';
import 'dart:developer';
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
  Future<String?> uploadImageToCloudinary(String selectedImage) async {
    // 
    try {
      // Cloudinary API endpoint
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dlqqi5b0q/upload');

      // Create multipart request
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'errandbuddy'
        ..files.add(await http.MultipartFile.fromPath('file', selectedImage));

      // Send the request
      final response = await request.send();

      // Check if the response status is successful
      if (response.statusCode == 200) {
        // Convert the response stream to a string
        final responseData = await response.stream.bytesToString();
        final jsonMap = jsonDecode(responseData);

        // Extract the image URL from the response
        final imageUrl = jsonMap['url'] as String?;

        if (imageUrl != null) {
          // Save the URL to Firebase
          // await saveImageUrlToFirebase(imageUrl);
          log(imageUrl);
          // Return the image URL
          return imageUrl;
        }
        
      } else {
        log('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error uploading image: $e');
    }

    // Return null if something went wrong
    return null;
  }
}
