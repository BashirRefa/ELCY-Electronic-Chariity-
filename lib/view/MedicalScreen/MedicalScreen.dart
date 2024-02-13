// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/controller/MedicalController/MedicalController.dart';
import 'package:first_app/models/MediaclModel/MedicalModel.dart';
import 'package:first_app/view/MedicalScreen/PostMedicalScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../NavigationBarScreen.dart';

class MedicalScreen extends StatelessWidget {
  MedicalScreen({Key? key, required this.namecategiry,required this.id}) : super(key: key);
  final String id;
  final String namecategiry;
  final MedicalController medicalcontroller = Get.put(MedicalController());

  Future<void> _refresh() async {
    // Perform the refresh operation here
    await Future.delayed(const Duration(seconds: 3));
    medicalcontroller.getAllMedical(id);
  }

  Color color = const Color(0xff172F45);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavigationBarScreen(),
      backgroundColor: color,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white, // Change the color to your desired color
        ),
        backgroundColor: color,
        title: Text(namecategiry,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
        centerTitle: true,
      ),
      body:RefreshIndicator(
        onRefresh: _refresh,
        child: Obx(() {
          medicalcontroller.getAllMedical(id);
          if (medicalcontroller.Medicals.isEmpty) {

            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Card(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue, // Placeholder color
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),


              ),
            );
          } else {

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: medicalcontroller.Medicals.length,
              itemBuilder: (context, index) {
                MedicalModel medical = medicalcontroller.Medicals[index];
                return GestureDetector(
                  onTap: () async{
                    print(medical.sId);
                    //go to post hospital or laboratores or عيادات
                    Get.to(() => PostMedicalScreen(namecpmany: medical.name!,id: medical.sId!,nameSp:namecategiry ), transition: Transition.fade);
                  },
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: '${medical.imageUrl}',
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(medical.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                );
              },
            );
          }
        }),
      ),
    );
  }
}

