import 'package:first_app/controller/CVcontroller/ControllerCV.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/toast.dart';
import '../NavigationBarScreen.dart';
import 'package:first_app/controller/ProfileController.dart';

import 'EditProfile.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xff172F45);

    ProfileController profileController = Get.put(ProfileController());
    CVController cvController=Get.put(CVController());

    return Scaffold(
      backgroundColor: color,
      bottomNavigationBar: const NavigationBarScreen(),
      appBar: AppBar(
        actions: [
          const Text('Edit',style: TextStyle(fontSize: 20,color: Colors.white),),
          IconButton(onPressed: (){
            Get.to(const EditProfileScreen());
            }, icon: const Icon(Icons.edit,color: Colors.white,),
          ),
        ],
        backgroundColor: color,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
              () {
                profileController.fetchUserData();
                cvController.fetchCVData();
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: TextEditingController(text: profileController.firstname.value),
                        type: TextInputType.text,
                        readOnly: true,
                        label: 'Firstname',
                        prefix: Icons.person,

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: TextEditingController(text: profileController.lastname.value),
                        type: TextInputType.text,
                        readOnly: true,
                        label: 'Last name',
                        prefix: Icons.person,

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: TextEditingController(text: profileController.email.value),
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        readOnly: true,
                        prefix: Icons.email_outlined,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: TextEditingController(text: profileController.phone.value),
                        type: TextInputType.number,
                        label: 'Phone',
                        readOnly: true,
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
                        controller: TextEditingController(text: profileController.gender.value),
                        type: TextInputType.text,
                        label: 'Gender',
                        readOnly: true,
                        prefix: Icons.person,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: TextEditingController(text: profileController.address.value),
                        type: TextInputType.text,
                        label: 'Address',
                        readOnly: true,
                        prefix: Icons.location_on,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: defaultFormField(
                        controller: TextEditingController(text: cvController.SkillsUser.value),
                        type: TextInputType.text,
                        label: 'Skills',
                        readOnly: true,
                        prefix: Icons.star,
                      ),
                    ),

                  ],
                );
              },
        ),
      ),
    );
  }
}
