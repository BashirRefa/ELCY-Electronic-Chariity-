import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/CreateProblemController/CreateProblemController.dart';
import '../../widgets/toast.dart';
class CreateProblemScreen extends StatelessWidget {
  final CreateProblemController controller = Get.put(CreateProblemController());

   CreateProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xff172F45);
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: color,
        title: const Text('Create Problem',style: TextStyle(fontSize: 30, color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),
            defaultFormField(
                controller: controller.titleController,
                type: TextInputType.text,
                label: 'Title',
                prefix: Icons.title,
            ),
            const SizedBox(height: 10.0),
            defaultFormField(
              controller: controller.descriptionController,
              type: TextInputType.text,
              label: 'Description',
              prefix: Icons.description,
            ),
            const SizedBox(height: 10.0),
            defaultFormField(
              controller: controller.priorityController,
              type: TextInputType.text,
              label: 'Priority',
              prefix: Icons.priority_high,
              hint: 'Please just use: low medium high '
            ),
            const SizedBox(height: 16.0),

            Button(
                isLoading: false,text: 'Create Problem', function: (){
              controller.createProblem();
              controller.titleController.clear();
              controller.descriptionController.clear();
              controller.priorityController.clear();
            }),
          ],
        ),
      ),
    );
  }
}