import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../api/API.dart';
import '../../models/SpecialtiesModel/Specialties.dart';

class SpecialtyController extends GetxController {
  RxList<Specialties> specialties = <Specialties>[].obs;
  //final CategoryController controller=Get.put(CategoryController());
  @override
  void onInit() {
    //getAllSpecialties(categories.id!);
    super.onInit();
  }

  Future<void> getAllSpecialties(String categoryId) async {
    try {
      String url=Applink.getAllSpecialties;
      final response = await http.get(Uri.parse('$url/$categoryId'));

      if (response.statusCode == 200) {
        final responseData =  json.decode(response.body);
        if (responseData.containsKey('specialties')) {
          // Map dynamic data to instances of Specialties class
          final List<dynamic> specialtiesData = responseData['specialties'];
          specialties.assignAll(specialtiesData.map((data) => Specialties.fromJson(data)));
        } else {
          throw Exception('Invalid response structure: Missing specialties key');
        }
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to connect to the server');
    }
  }
}
