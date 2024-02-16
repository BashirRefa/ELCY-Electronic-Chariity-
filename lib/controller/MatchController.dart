import 'package:first_app/api/API.dart';
import 'package:first_app/shared_preferene/cach_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/MatchedResults.dart'; // Import for json.decode

class MatchController extends GetxController {

  var matchedResults = <MatchedResults>[].obs;
  var isLoading = true.obs;
  var companyInfo = {}.obs;

  void fetchMatchedResults() async {
    try {
      String userID=CachedHelper.getData(key: 'id');
      //658d9390cac87e1f20e5fdfe
      final response = await http.get(Uri.parse('${Applink.matchPostsToCV}/$userID'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        matchedResults.value = data.map((json) => MatchedResults.fromJson(json)).toList();

        isLoading.value = false;

      } else {
        print('Failed to load matched results: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading matched results: $error');
    }
  }
  Future<void> fetchCompanyInfo(String companyId) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('${Applink.getCompany_info}/$companyId'));

      //print(response.body);
      if (response.statusCode == 200) {
        companyInfo(json.decode(response.body));
      } else {
        throw Exception('Failed to load company info');
      }
    } finally {
      isLoading(false);
    }
  }


}
