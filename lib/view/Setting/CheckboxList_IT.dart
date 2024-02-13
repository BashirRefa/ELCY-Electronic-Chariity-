
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/CheckboxController/CheckboxController.dart';




class CheckboxList extends StatelessWidget {
  final CheckboxController checkboxController = Get.put(CheckboxController());

   CheckboxList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox List Example'),
      ),
      body: Obx(
            () => ListView.builder(
              itemCount: checkboxController.isCheckedList.length,
              itemBuilder: (context, index) {
                String checkboxLabel;
                switch (index) {
                case 0:
                  checkboxLabel = 'Flutter';
                  break;
                case 1:
                  checkboxLabel = 'Node.js';
                  break;
                  case 2:
                    checkboxLabel='viewjs';
                    break;
                  case 3:
                    checkboxLabel='laravel';
                    break;
                  case 4:
                    checkboxLabel='asp.net';
                    break;
                  case 5:
                    checkboxLabel='django';
                    break;
                  case 6:
                    checkboxLabel='machine learning';
                    break;
              // Add more cases for other checkboxes as needed
                default:
                  checkboxLabel = 'Checkbox $index';
                  break;
              }
              return CheckboxListTile(
                title: Text(checkboxLabel),
                value: checkboxController.isCheckedList[index],
                onChanged: (value) {
                  checkboxController.toggleCheckboxState(index, value!);
                  },
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              );
                },
            ),
      ),
    );
  }
}

