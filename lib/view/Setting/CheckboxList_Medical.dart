import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/CheckboxController/CheckboxController.dart';

class CheckboxListMedical extends StatelessWidget {
  final CheckboxController checkboxController = Get.put(CheckboxController());

  CheckboxListMedical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> checkboxLabels = [
      'أجهزة التصوير الطبي (Medical Imaging Devices)',
      'تقنيات التصوير الطبي الرقمي (Digital Medical Imaging)',
      'أجهزة قياس العلامات الحيوية (Vital Signs Monitoring Devices)',
      'أجهزة العناية المركزة (Intensive Care Unit Devices)',
      'الروبوتات الجراحية (Surgical Robots)',
      'أجهزة القلب والأوعية الدموية (Cardiovascular Devices)',
      'تقنيات الرعاية الطبية عن بعد (Telemedicine Technologies)',
      'أجهزة التحكم في الألم (Pain Management Devices)',
      'التصميم البيوميكانيكي (Biomechanical Design)',
      'تقنيات تجديد الأعضاء (Organ Regeneration Technologies)',
      'أطراف صناعية',
      'تصنيع الأجهزة الطبية (Medical Device Manufacturing)',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox List Medical'),
      ),
      body: ListView.builder(
        itemCount: 11,
        itemBuilder: (context, index) {
          return Obx(() => CheckboxListTile(
            title: Text(checkboxLabels[index]),
            value: checkboxController.isCheckedListMedical[index],
            onChanged: (value) {
              checkboxController.toggleCheckboxState2(index, value!);
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ));
        },
      ),
    );
  }
}
