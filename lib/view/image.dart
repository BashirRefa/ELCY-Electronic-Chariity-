
import 'package:first_app/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ImageUploadController.dart';

class ImageUploadScreen extends StatelessWidget {
  ImageUploadScreen({super.key});

  final ImageUploadController controller = Get.put(ImageUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            Obx(() => Button(
              text: 'Pick and Upload Image',
              function: controller.uploadImage,
              isLoading: controller.uploading.value,
            ),

            ),
          ],
        ),
      ),
    );
  }
}
