import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/controller/ProfileController.dart';
import '../../widgets/toast.dart';
import '../NavigationBarScreen.dart';
import 'package:first_app/models/ProfileMode.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xff172F45);


    return Scaffold(
      backgroundColor: color,
      bottomNavigationBar: const NavigationBarScreen(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        backgroundColor: color,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              key: controller.formSignInKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: defaultFormField(
                      controller: controller.firstname2,
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
                      controller: controller.lastname2,
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
                      controller: controller.phone2,
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
                      controller: controller.address2,
                      type: TextInputType.text,
                      label: 'Address',
                      prefix: Icons.wrong_location_sharp,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Gender';
                        }
                        return null;
                      },
                    ),
                  ),
                  Button(
                      isLoading: false,text: 'Edit', function: () {
                    controller.editProfile(
                      ProfileMode(
                        firstName: controller.firstname2.text,
                        lastName: controller.lastname2.text,
                        phoneNumber: controller.phone2.text,
                        address: controller.address2.text,
                      ),
                    );

                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
