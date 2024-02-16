
import 'package:first_app/view/CreateProblemScreen/CreateProblemScreen.dart';
import 'package:first_app/view/NavigationBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/toast.dart';
import '../ShowPostsimilarity/Show Post similarity.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xff172F45);
    return Scaffold(
      backgroundColor: color,
      bottomNavigationBar:const  NavigationBarScreen(),
      appBar: AppBar(
        backgroundColor: color,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const  Text('Setting',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Image.asset('assets/images/Login.png',scale: 6,),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
         const  SizedBox(height: 30,),
          Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Button(isLoading: false,text: 'Send Problem', function:(){
                Get.to(CreateProblemScreen());
              }),
             const SizedBox(height: 20,),
              Button(isLoading: false,text: 'Show Post similarity', function:(){
                Get.to(MatchScreen());
              }),
            ],
          ),
        ],
      ),
    );
  }
}
