// ignore_for_file: must_be_immutable

import 'package:first_app/controller/LoginController.dart';
import 'package:first_app/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/login_model.dart';
import 'RegisterScreen.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  LoginController loginController=Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key:loginController.formSignInKey,
      child: Scaffold(
        backgroundColor: loginController.color,
        body: Obx(() {

          return SafeArea(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Image.asset('assets/images/Login.png',scale: 4,),
                  const Text('ELCY',style: TextStyle(fontSize: 30, color: Colors.white),),
                  const SizedBox(height: 15),
                  const Text(
                    "! Welcome Back",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(20),
                    child: defaultFormField(
                      controller: loginController.emailcontroller,
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
                      controller: loginController.passwordController,
                      type: TextInputType.text,
                      validate:  (value) {
                        if (value == null || value.isEmpty ) {
                          return 'Please enter Password';
                        }
                        return value.length < 8 ? 'Minimum character length is 8' : null;
                      },
                      prefix: Icons.lock,
                      isPassword: loginController.passwordvisible.value,
                      label: 'Password',
                      sufix: loginController.passwordvisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixf: () {
                        loginController.togglePasswordVisibility();
                      },
                      onChange: (value) {
                        loginController.passwordController.text = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                              height: Get.height * 0.5, // Adjust the height as needed
                              width: Get.width,
                              decoration:const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Enter your email to reset your password',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  const  SizedBox(height: 16.0),
                                  TextFormField(
                                    decoration:const InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: () {

                                      Get.back();
                                    },
                                    child:const Text('Reset Password'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child:const Text(
                          '?Forget password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(RegisterScreen());
                        },
                        child:const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Button(
                    isLoading: false,
                      text: 'sign in',
                      function: ()  {
                        if (loginController.formSignInKey.currentState!.validate()) {
                          loginController.login(
                            LoginRequest(
                                email: loginController.emailcontroller.text,
                                password:loginController.passwordController.text),
                          );

                        } else
                        {
                          ShowTost(text: 'Plase enter your info',
                              states: ToastStates.ERROR);
                        }
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/img.png',
                        scale: 1.0,
                      ),
                    ],
                  ),

                ],

              ),

            ),
          );
        },)
    ),
    );
  }
}
