import 'dart:convert';
import 'dart:io';

import 'package:first_app/api/API.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploadController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  RxBool uploading = false.obs;

  Future<void> uploadImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String name = nameController.text;
        uploading.value = true;

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('${Applink.server}/api/upload'),
        );
        request.fields['name'] = name;
        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

        var response = await request.send();
        if (response.statusCode == 200) {
          print('Image uploaded successfully');
          Get.snackbar(
            'Success',
            'Image uploaded successfully',

            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            snackStyle: SnackStyle.FLOATING,
            backgroundColor: Color.fromRGBO(255, 158, 143, 1),
            colorText: Colors.white,
            titleText: Text(
              'Success',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),

          );
        } else {
          print('Failed to upload image');
        }

        uploading.value = false;
      } else {
        print('No image selected.');
      }
    } catch (error) {
      print('Error uploading image: $error');
      uploading.value = false;
    }
  }
}