// ignore_for_file: must_be_immutable

import 'package:first_app/controller/RegisterController.dart';
import 'package:first_app/models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/toast.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerController.formSignupKey,
      child: Scaffold(
        backgroundColor: registerController.color,
        body: GetBuilder<RegisterController>(
          builder: (controller) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    Image.asset('assets/images/Login.png', scale: 4,),
                    const Text('ELCY', style: TextStyle(fontSize: 30, color: Colors.white),),
                    const SizedBox(height: 15),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: registerController.firstname,
                        type: TextInputType.text,
                        label: 'Firstname',
                        prefix: Icons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter firstname';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: registerController.lastname,
                        type: TextInputType.text,
                        label: 'Last name',
                        prefix: Icons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter lastname';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: registerController.email,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        prefix: Icons.email_outlined,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }

                          final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: defaultFormField(
                        controller: registerController.password,
                        type: TextInputType.text,
                        validate:  (value) {
                          if (value == null || value.isEmpty ) {
                            return 'Please enter Password';
                          }
                          return value.length < 8 ? 'Minimum character length is 8' : null;
                        },
                        prefix: Icons.lock,
                        isPassword: registerController.passwordvisible.value,
                        label: 'Password',
                        sufix: registerController.passwordvisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixf: () {
                          registerController.togglePasswordVisibility();
                        },
                        onChange: (value) {

                          registerController.password.text = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: registerController.phone,
                        type: TextInputType.number,
                        label: 'Phone',
                        prefix: Icons.phone,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: registerController.birsthday,
                        type: TextInputType.number,
                        label: 'birsthday',
                        hint: '2000-01-01',
                        prefix: Icons.date_range_outlined,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter birsthday';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: registerController.gender,
                        type: TextInputType.text,
                        label: 'Gender',
                        prefix: Icons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Gender';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: registerController.address,
                        type: TextInputType.text,
                        label: 'Address',
                        prefix: Icons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Button(
                      isLoading: false,
                        text: 'sign in',
                        function: ()  {
                          if (registerController.formSignupKey.currentState!.validate()) {
                            registerController.register(
                              RegisterModel(firstname: controller.firstname.text,
                                lastname: controller.lastname.text,
                                email: controller.email.text,
                                password: controller.password.text,
                                phoneNumber: controller.phone.text,
                                birthday: controller.birsthday.text,
                                gender: controller.gender.text,
                                address: controller.address.text,

                              ),
                            );
                            controller.firstname.clear();
                            controller.lastname.clear();
                            controller.email.clear();
                            controller.password.clear();
                            controller.phone.clear();
                            controller.birsthday.clear();
                            controller.gender.clear();

                          } else
                          {
                            ShowTost(text: 'Error',
                                states: ToastStates.ERROR);
                          }
                        }),
                    const SizedBox(height: 25,),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
