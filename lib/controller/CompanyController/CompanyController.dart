import 'dart:convert';

import 'package:get/get.dart';

import '../../api/API.dart';
import '../../models/Company/CompanyModel.dart';
import 'package:http/http.dart' as http;
class CompanyController extends GetxController {
  var companies = <Comapny>[].obs;

  Future<void> getcompany(String id) async {
    String uri = Applink.getcompany;

    try {
      final response = await http.get(Uri.parse('$uri/$id'));

      if (response.statusCode == 200) {
        // Parse the JSON string into a list of Company objects
        List<dynamic> parsedCompanies = json.decode(response.body);
        List<Comapny> companyList = parsedCompanies.map((json) => Comapny.fromJson(json)).toList();

        // Update the observable list
        companies.assignAll(companyList);
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
