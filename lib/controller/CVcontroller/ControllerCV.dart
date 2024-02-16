import 'dart:convert';

import 'package:first_app/api/API.dart';
import 'package:first_app/models/getcvModel/getcvModel.dart';
import 'package:first_app/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../shared_preferene/cach_helper.dart';

class CVController extends GetxController {
  RxList<String> selectedSkills = <String>[].obs;
  RxString selectedDivision = 'informationEngineering'.obs;

   var cvData = {}.obs;
  var isLoading = true.obs;
  var SkillsUser=''.obs;

  List<String> getSkillsForDivision(String division) {
    final divisionOptions = {
      'informationEngineering': [
        'front end', 'backend', 'flutter', 'nodejs', 'viewjs', 'AI',
        'laravel', 'asp.net', 'django', 'go', 'rube', 'machine learning',
        'deep learning', 'java', 'c#', 'c', 'c++', 'network', 'neural network',
        'software', 'search engine', 'web design', 'web development', 'UI',
        'oop', 'information security', 'data analysis', 'Mobile app development'
      ],
      'civil': [
        'Structural Engineering', 'Aotucade', '3D Max',
        'Roads and bridges engineering (Transportation Engineering)',
        'Water Resources Engineering', 'Construction Management Engineering',
        'Engineering Design', 'Engineering Inspection', 'Engineering Project Management',
        'Engineering Quality', 'Structural Analysis', 'Infrastructure',
        'Architectural Design', 'Excavation and Excavating', 'Cost Estimation'
      ],
      'architecture': [
        'Architectural Design', 'Urban Planning', 'Architectural Facade',
        'Interior Design', 'Architectural Plans', 'Sustainable Design',
        'Landscape Design', 'Structural Design', 'Lighting Design',
        'Open Design', 'Glass Facade Design', 'Architectural Integration'
      ],
      'medical': [
        'Medical imaging devices', 'Digital Medical Imaging Techniques',
        'Vital Signs Monitoring Devices', 'Intensive Care Unit Devices',
        'Surgical Robots', 'Cardiovascular Devices', 'Telemedicine Technologies',
        'Pain Management Devices', 'Biomechanical Design', 'Organ Regeneration Technologies',
        'Artificial limbs', 'Medical Device Manufacturing'
      ],
    };

    return divisionOptions[division]!;
  }

  Future<void> submitCV() async {
    print('Selected Division: $selectedDivision');
    print('Selected Skills: $selectedSkills');

    final cleanedSkills = selectedSkills
        .map((skill) => skill.replaceAll(RegExp(r'[^\w\s]'), ''))
        .join(',');
    String? idCustom = CachedHelper.getData(key: 'id');
    final String url = '${Applink.AddCV}/$idCustom';
    final Map<String, dynamic> data = {
      'engineeringDivision': selectedDivision.value,
      'Skills': cleanedSkills,
    };
    final http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('CV submitted successfully!');
      ShowTost(text: '${response.body}', states: ToastStates.SUCCESS);
    } else {
      print('Error submitting CV: ${response.body}');
      ShowTost(text: '${response.body}', states: ToastStates.ERROR);
    }
  }

  Future<void> fetchCVData() async {
    try {

      String customerId=CachedHelper.getData(key: 'id');
      final response = await http.get(Uri.parse('${Applink.getCV_customer}/$customerId'));

      if (response.statusCode == 200) {
        cvData.value = json.decode(response.body);
        var responseData = jsonDecode(response.body);
        SkillsUser(responseData['Skills']);
        isLoading.value = false;
      } else {
        print('Failed to load CV data: ${response.statusCode}');
        print('Failed to load CV data: ${response.statusCode}');
        throw Exception('Failed to load CV data');
      }
    } catch (error) {
      print('Error loading CV data: $error');
      throw Exception('Error loading CV data');
    }
  }

}