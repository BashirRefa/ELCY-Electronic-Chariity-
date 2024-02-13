import 'package:first_app/api/API.dart';
import 'package:first_app/shared_preferene/cach_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for json.decode

class MatchController extends GetxController {
  final matchedResults = [].obs;
  final companyInfo=[].obs;

  final userData = {}.obs;
  final isLoading = false.obs;

  // Future<void> fetchUserData(String Idcustom) async {
  //   try {
  //     // print(id);
  //     String url='http://192.168.43.79:3000/api/getCompany_info';
  //     // print('$url/$id');
  //
  //     var response = await http.get(Uri.parse('$url/$Idcustom'));
  //
  //     if (response.statusCode == 200) {
  //       // print(id);
  //       var responseData = jsonDecode(response.body);
  //       //print(responseData);
  //       companyInfo.add(responseData);
  //       print(companyInfo);
  //
  //     } else {
  //       throw Exception('Failed to fetch user data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }


  Future<void> fetchMatchedResults() async {
    String userID=CachedHelper.getData(key: 'id');
    final url = '${Applink.server}/api/matchPostsToCV/658d9390cac87e1f20e5fdfe';

    try {
      final response = await http.get(Uri.parse(url)); // Use http.get and Uri.parse

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON response
        List<dynamic> jsonResponse = json.decode(response.body); // Parse response body as JSON

        // Convert the JSON response into a list of Maps
        List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(jsonResponse);

        matchedResults.value = results;

        print(results);
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load matched results');
      }
    } catch (error) {
      // Handle any errors that occur during the HTTP request
      print('Error fetching matched results: $error');
      throw error;
    }
  }

  Future<void> fetchUserData(String companyId) async {
    String url='http://192.168.43.79:3000/api/getCompany_info/$companyId';
    isLoading.value = true; // Set isLoading to true when fetching data

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        userData.value = json.decode(response.body);
      } else {
        throw Exception('Failed to load company information');
      }
    } catch (error) {
      print('Error fetching company information: $error');
      throw error;
    } finally {
      isLoading.value = false; // Set isLoading back to false after fetching data
    }
  }

}
