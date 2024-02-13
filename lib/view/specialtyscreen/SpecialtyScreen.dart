// ignore_for_file: must_be_immutable

import 'package:first_app/view/CompanyScreen/CompanyScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/SpecialtiesController/SpecialtiesController.dart';
import '../../models/SpecialtiesModel/Specialties.dart';
import '../NavigationBarScreen.dart';
class SpecialtyScreen extends StatelessWidget {
  SpecialtyScreen({super.key,required this.namespe,required this.id});
  String id;
  String namespe;
  final SpecialtyController specialtyController = Get.put(SpecialtyController());

  Future<void> _refresh() async {

    await Future.delayed(const Duration(seconds: 3));
    specialtyController.getAllSpecialties(id);
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
          color: Colors.white,
        ),
        backgroundColor: color,
        title: Text(namespe,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
        centerTitle: true,
      ),
      body:RefreshIndicator(
        onRefresh: _refresh,
        child: Obx(() {
          specialtyController.getAllSpecialties(id);

          if(specialtyController.specialties.isEmpty){
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Card(
                  shape: const CircleBorder(),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),


              ),
            );
          }
          else{
            return  GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount:specialtyController.specialties.length ,
              itemBuilder: (context, index) {
                Specialties specialty = specialtyController.specialties[index];
                return GestureDetector(
                  onTap: () async{
                    print(specialty.sId);
                    Get.to(CompanyScreen(CompanyName: specialty.name!,id:specialty.sId!),transition: Transition.fade);

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(30.0), // You can adjust the radius as needed
                              child: Image.network(
                                '${specialty.imageUrl}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                              padding:const EdgeInsets.all(8),
                            child: Text(
                              specialty.name!,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                );
              },
            );
          }
        } ),

      ),
    );
  }
}