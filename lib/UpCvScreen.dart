// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/CVcontroller/ControllerCV.dart';
class UpCvScreen extends StatelessWidget {
   UpCvScreen({super.key,required this.NameCompany});
   String NameCompany;
   final CVController cvController = Get.put(CVController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload CV '),
      ),
      body: SingleChildScrollView(
        child: Obx((){
          cvController.selectedDivision.value = NameCompany;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [NameCompany]
                      .map<Widget>((String division) {
                    return CheckboxListTile(
                      title: Text(division),
                      value: cvController.selectedDivision == division,
                      onChanged: (bool? value) {
                        cvController.selectedDivision.value = division;
                        cvController.selectedSkills.clear();
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text(':Select One Skill'),
                Column(
                  children: cvController
                      .getSkillsForDivision(cvController.selectedDivision.value)
                      .map((skill) => RadioListTile<String>(
                    title: Text(skill),
                    value: skill,
                    groupValue: cvController.selectedSkills.isNotEmpty
                        ? cvController.selectedSkills[0]
                        : null,
                    onChanged: (String? value) {
                      if (value != null) {
                        cvController.selectedSkills.clear();
                        cvController.selectedSkills.add(value);
                      }
                    },
                  ),
                  ).toList(),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (cvController.selectedDivision.isNotEmpty &&
                        cvController.selectedSkills.isNotEmpty) {
                      cvController.submitCV();
                    } else {
                      print('Please select a division and a skill.');
                    }
                    Get.back();
                  },
                  child: const Text('Submit'),
                ),

              ],
            ),
          );
        }),
      ),
    );
  }
}