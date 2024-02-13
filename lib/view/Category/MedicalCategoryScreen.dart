// ignore_for_file: must_be_immutable

import 'package:first_app/controller/CategoryController/MedicalCategoryController.dart';
import 'package:first_app/models/CategoryModel/Category.dart';
import 'package:first_app/view/MedicalScreen/MedicalScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../NavigationBarScreen.dart';
import '../PharmacyScreen/PharmaciesScreen.dart';

class MedicalCategoryScreen extends StatelessWidget {
  MedicalCategoryScreen({Key? key, required this.namecategiry,required this.id}) : super(key: key);
  final String id;
  final String namecategiry;
  final MedicalCategoryController categoryController = Get.put(MedicalCategoryController());

  Future<void> _refresh() async {
    // Perform the refresh operation here
    await Future.delayed(const Duration(seconds: 3));
    categoryController.getMedicalAllCategories(id);
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
          categoryController.getMedicalAllCategories(id);
          if (categoryController.categories.isEmpty) {

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
              itemCount: categoryController.categories.length,
              itemBuilder: (context, index) {
                Categories category = categoryController.categories[index];
                return GestureDetector(
                  onTap: () async{
                    print(category.id);
                    if(category.name=='pharmacy' ||category.id=='65a8222a628565a2abc7eb0b') {
                     return Get.to(() =>
                          PharmacyScreen(
                              namecategiry: category.name!, id: category.id!),
                          transition: Transition.fade);
                    }
                    else
                      {
                        return Get.to(() =>
                            MedicalScreen(
                                namecategiry: category.name!, id: category.id!),
                            transition: Transition.fade);
                      }

                  },
                  child: Card(
                    shape: const CircleBorder(),
                    elevation: 3,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0), // You can adjust the radius as needed
                            child: Image.network(
                              '${category.urlImage}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(category.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

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

