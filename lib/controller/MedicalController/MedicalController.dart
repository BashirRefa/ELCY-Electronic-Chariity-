import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../api/API.dart';
import '../../models/MediaclModel/MedicalModel.dart';

class MedicalController extends GetxController{
  RxList<MedicalModel> Medicals = <MedicalModel>[].obs;


  Future<void> getAllMedical(String MedicalId) async {
    try {
      String url=Applink.getAllPharmacy;
      final response = await http.get(Uri.parse('$url/$MedicalId'));

      if (response.statusCode == 200) {
        final responseData =  json.decode(response.body);
        if (responseData.containsKey('group')) {
          // Map dynamic data to instances of Specialties class
          final List<dynamic> MedicalData = responseData['group'];
          Medicals.assignAll(MedicalData.map((data) => MedicalModel.fromJson(data)));
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