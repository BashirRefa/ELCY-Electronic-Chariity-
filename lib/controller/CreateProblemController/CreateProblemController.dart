import 'dart:convert';
import 'package:first_app/api/API.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../shared_preferene/cach_helper.dart';

class CreateProblemController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  Future<void> createProblem() async {
    try {
      String iduser=CachedHelper.getData(key: 'id');
      String url='${Applink.problems}/$iduser/65c379c646f6181772e8b5a1';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': titleController.text,
          'description': descriptionController.text,
          'priority': priorityController.text,
        }),
      );

      if (response.statusCode == 201) {
        //Get.snackbar('Success', 'Problem created successfully');
        Get.snackbar(
          'Success',
          'Problem created successfully',

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
      } else if(response.statusCode == 500){
        Map<String, dynamic> responseBody = json.decode(response.body);
        String message=responseBody['message'];
        print('message adjhkjsv $message');
        Get.snackbar('Error',message);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }
}