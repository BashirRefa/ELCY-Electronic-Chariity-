import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../api/API.dart';
import '../../models/PharmacyModel/ModelDrug.dart';
import '../../models/PharmacyModel/PharmacyModel.dart';

class PharmacyController extends GetxController{
  RxList<ModelGroupPharmacy> Pharmacies = <ModelGroupPharmacy>[].obs;


  RxList<DrugModel> Druges = <DrugModel>[].obs;

  Future<void> getAllPharmacy(String pharmaId) async {
    try {
      String url=Applink.getAllPharmacy;
      final response = await http.get(Uri.parse('$url/$pharmaId'));

      if (response.statusCode == 200) {
        final responseData =  json.decode(response.body);
        if (responseData.containsKey('group')) {
          // Map dynamic data to instances of Specialties class
          final List<dynamic> pharmaciesData = responseData['group'];
          Pharmacies.assignAll(pharmaciesData.map((data) => ModelGroupPharmacy.fromJson(data)));
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



  Future<void> getAllDruges(String pharmaId) async {
    try {
      String url=Applink.getAllDrug;
      final response = await http.get(Uri.parse('$url/$pharmaId'));

      if (response.statusCode == 200) {
        final responseData =  json.decode(response.body);
        if (responseData.containsKey('drugs')) {
          // Map dynamic data to instances of Specialties class
          final List<dynamic> DrugsData = responseData['drugs'];
          Druges.assignAll(DrugsData.map((data) => DrugModel.fromJson(data)));
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