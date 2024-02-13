// PostController.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api/API.dart';
import '../../models/PostModel/PostModel.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;


  RxList<Post> postsmedical=<Post>[].obs;


  Future<void> getAllPosts(String companyId) async {
    try {
      String uri = Applink.getpostCompany;
      final response = await http.get(Uri.parse('$uri/$companyId'));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['post'] as List<dynamic>;
        posts.assignAll(decodedData.map((postJson) => Post.fromJson(postJson)).toList());

      } else {
        throw Exception('Failed to load posts - Status Code: ${response.statusCode}');

      }
    } catch (e) {
      posts.clear();
      print('An error occurred: $e');
      throw Exception('Failed to load posts: $e');
    }
  }



  Future<void> getAllPostsMedical(String medicalId) async {
    try {
      String uri = Applink.getAllPostMedical;
      final response = await http.get(Uri.parse('$uri/$medicalId'));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body)['medicalPost'] as List<dynamic>;
        postsmedical.assignAll(decodedData.map((postJson) => Post.fromJson(postJson)).toList());

      } else {
        throw Exception('Failed to load posts - Status Code: ${response.statusCode}');

      }
    } catch (e) {
      posts.clear();
      postsmedical.clear();
      print('An error occurred: $e');
      throw Exception('Failed to load posts: $e');
    }
  }


}
