import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api/API.dart';
import '../../models/ServicesModel/Service.dart';
import '../../models/imagemodel.dart';

class ServiceController extends GetxController {
  var imageModel = ImageModel().obs;
  @override
  void onInit() {
    super.onInit();
    getAllServices();
  }

  RxList<Services> services = <Services>[].obs;

  Future<void> getAllServices() async {
    try {
      final response = await http.get(Uri.parse(Applink.getAllServices));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);

        // Ensure that 'services' is an array in the received JSON
        final List<dynamic> servicesData = data['services'];

        // Clear the existing list before assigning new values
        services.clear();

        // Use map to convert each service data to a Services object
        services.addAll(servicesData.map((service) => Services.fromJson(service)));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

}

