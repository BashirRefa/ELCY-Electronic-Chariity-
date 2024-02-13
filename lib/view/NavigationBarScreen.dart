import 'package:first_app/controller/NavigationBarController.dart';
import 'package:first_app/view/Home_screen.dart';
import 'package:first_app/view/LoginScreesn.dart';
import 'package:first_app/view/Profile/ProfileScreen.dart';
import 'package:first_app/view/Setting/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared_preferene/cach_helper.dart';

class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(NavigationBarController());

    return Obx(() {
      return NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) async {
          controller.selectedIndex.value=index;
          switch(index){
            case 0:
              Get.offAll(const HomeScreen());
              break;
            case 1:
              Get.offAll(const SettingsScreen());
              break;
            case 2:
              Get.offAll(const ProfileScreen());
              break;

            case 3:
              await CachedHelper.clearData(key: 'token');
              Get.offAll(LoginScreen());
              break;
            default:
          }
          if (index == 3) {
            controller.selectedIndex.value = 0;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'home',),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
          NavigationDestination(icon: Icon(Icons.person_pin), label: 'profile'),
          NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
        ],
      );
    },);
  }
}
