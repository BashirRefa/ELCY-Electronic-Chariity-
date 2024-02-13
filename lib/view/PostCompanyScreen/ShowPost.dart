// ignore_for_file: must_be_immutable

import 'package:first_app/controller/PostController/PostController.dart';
import 'package:first_app/models/PostModel/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../UpCvScreen.dart';
import '../NavigationBarScreen.dart';

class ShowPostScreen extends StatelessWidget {
  ShowPostScreen({Key? key, required this.namecpmany, required this.post,required this.nameSp}) : super(key: key);

  Post post;
  final String namecpmany;
  final String nameSp;

  final PostController postController = Get.put(PostController());
  Color color = const Color(0xff172F45);

  Future<void> _refresh() async {

    await Future.delayed(const Duration(seconds: 3));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavigationBarScreen(),
      backgroundColor: color,
      appBar: AppBar(
        actions: nameSp == 'informationEngineering' ||  nameSp =='civil' ||  nameSp =='architecture' || nameSp=='medical'
            ? [
          IconButton(
            onPressed: () {
              Get.to(UpCvScreen(NameCompany: nameSp));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ]
            : [], // Empty list if nameSp is null
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white, // Change the color to your desired color
        ),
        backgroundColor: color,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(namecpmany,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Image.asset('assets/images/Login.png',scale: 6,),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child:Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10,),
             Center(
               child: Text(post.title ?? '',
                 style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 20),
               ),
             ),
             const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(post.content ?? '',
                style: const TextStyle(fontWeight: FontWeight.w100),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}