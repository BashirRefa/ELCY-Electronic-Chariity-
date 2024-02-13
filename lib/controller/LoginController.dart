
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';

import '../api/API.dart';
import '../models/login_model.dart';
import '../shared_preferene/cach_helper.dart';
import '../view/Home_screen.dart';
import '../widgets/toast.dart';

class LoginController extends GetxController{
  bool rememberPassword = true;
  RxBool passwordvisible = true.obs;
  final formSignInKey = GlobalKey<FormState>();
  final emailcontroller=TextEditingController();
  final passwordController=TextEditingController();
  Color color = const Color(0xff172F45);

  var firstname = ''.obs;
  var lastname = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var age = ''.obs;
  var address = ''.obs;
  var gender=''.obs;
  void boolRememberPassword(){
    rememberPassword==false? rememberPassword:true;
  update();
  }

    void togglePasswordVisibility() {
      passwordvisible.value = !passwordvisible.value;
    }

  Future<void> login(LoginRequest request) async {
    String url = Applink.login;

    var response = await http.post(
      Uri.parse(url),
      body: {
        'email': request.email,
        'password': request.password,
      },
    );

    if (response.statusCode == 200) {
      // Login successful
      Map<String, dynamic> responseBody = json.decode(response.body);
      String token = responseBody['accessToken']; // Assuming 'token' is the key in the response
      String firstname=responseBody['name'];
      String id=responseBody['id'];
      // Save the token in SharedPreferences
      await CachedHelper.putData(key: 'token', value: token);
      await CachedHelper.putData(key: 'id', value: id);


      print('Login successful');
      print(response.body);

      Get.off(HomeScreen());
      Get.snackbar(
        'Welcome',
        '${firstname}.',

        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Color.fromRGBO(255, 158, 143, 1),
        colorText: Colors.white,
        titleText: Text(
          'Welcome',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        messageText: Text(
          '${firstname}.',
          style: TextStyle(fontSize: 18,color: Colors.white),
        ),
      );
      ShowTost(text: 'Login successful', states: ToastStates.SUCCESS);
    } else {
      // Invalid username or password
      ShowTost(text: 'Invalid username or password',
          states: ToastStates.ERROR);
      print('Invalid username or password');
    }
  }


}