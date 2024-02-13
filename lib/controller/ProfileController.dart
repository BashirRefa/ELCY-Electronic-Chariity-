// profile_controller.dart
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/API.dart';
import '../models/ProfileMode.dart';
import '../shared_preferene/cach_helper.dart';
import '../widgets/toast.dart';

class ProfileController extends GetxController {
  var firstname = ''.obs;
  var lastname = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var age = ''.obs;
  var address = ''.obs;
  var gender=''.obs;

  var SkillsUser=''.obs;

  final formSignInKey = GlobalKey<FormState>();
  final firstname2=TextEditingController();
  final lastname2=TextEditingController();
  final phone2=TextEditingController();
  final address2=TextEditingController();


  String? id = CachedHelper.getData(key: 'id');

  Future<void> fetchUserData() async {
    try {
     // print(id);
      String url=Applink.getCustomer_info;
     // print('$url/$id');

      var response = await http.get(Uri.parse('$url/$id'));

      if (response.statusCode == 200) {
       // print(id);
        var responseData = jsonDecode(response.body);
        //print(responseData);
        firstname(responseData['firstName']);
        lastname(responseData['lastName']);
        email(responseData['email']);
        phone(responseData['phoneNumber']);
        gender(responseData['gender']);
        address(responseData['address']);
        String? Skills=await CachedHelper.getData(key: 'SkillsUser');
        SkillsUser(Skills);
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> editProfile(ProfileMode profileMode) async{
    String uri=Applink.editCustomer;
    var response=await http.put(
      Uri.parse('$uri/$id'),
      headers: {'Content-Type': 'application/json'},
      body:jsonEncode( {
        'firstName':profileMode.firstName,
        'lastName':profileMode.lastName,
        'phoneNumber':profileMode.phoneNumber,
        'address':profileMode.address,
      }),
    );
    if(response.statusCode==200)
    {
      print('Edit successful');
      ShowTost(text: response.body, states: ToastStates.SUCCESS);
    }
    else
    {
      ShowTost(text: response.body, states: ToastStates.WARNING);
    }
  }


  @override
  void onInit() {
    super.onInit();
  }
}
