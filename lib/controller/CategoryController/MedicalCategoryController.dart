
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api/API.dart';
import '../../models/CategoryModel/Category.dart';
import '../ServicesController/ServicesController.dart';


class MedicalCategoryController extends GetxController {
  var categories = <Categories>[].obs;
  ServiceController controller=Get.put(ServiceController());

  Future<void> getMedicalAllCategories(String serviceId) async {
    try {
      final url = '${Applink.getMedicalAllCategory}/$serviceId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> categoryList = jsonResponse['medicalCategory'];

        categories.assignAll(categoryList.map((json) => Categories.fromJson(json)));
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
