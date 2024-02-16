
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../api/API.dart';
import '../models/register_model.dart';
import '../view/LoginScreesn.dart';
import '../widgets/toast.dart';

class RegisterController extends GetxController{
  bool agreePersonalData = true;
  final formSignupKey = GlobalKey<FormState>();
  Color color = const Color(0xff172F45);

  final firstname=TextEditingController();
  final lastname=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final phone=TextEditingController();
  final birsthday=TextEditingController();
  final gender=TextEditingController();
  final address=TextEditingController();

  RxBool passwordvisible = true.obs;

  void togglePasswordVisibility() {
    passwordvisible.value = !passwordvisible.value;
  }


  void boolagreePersonalData(){
    agreePersonalData==false?agreePersonalData:true;
    update();
  }
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  Future<void> selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> register(RegisterModel registerModel) async{
    String uri=Applink.register;
    var response=await http.post(
      Uri.parse(uri),
    body: {
      'firstName':registerModel.firstname,
      'lastName':registerModel.lastname,
      'gender':registerModel.gender,
      'phoneNumber':registerModel.phoneNumber,
      'password':registerModel.password,
      'email':registerModel.email,
      'address':registerModel.address,
      'birthday':registerModel.birthday,
    },
    );
    if(response.statusCode==200)
      {
        print('Register successful');
        Get.offAll(LoginScreen());
        ShowTost(text: response.body, states: ToastStates.SUCCESS);
      }
    else
      {
        ShowTost(text: response.body, states: ToastStates.WARNING);
      }
  }
}