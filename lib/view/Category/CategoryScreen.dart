// ignore_for_file: must_be_immutable
import 'package:first_app/controller/ServicesController/ServicesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/CategoryController/CategoryController.dart';
import '../../models/CategoryModel/Category.dart';
import '../NavigationBarScreen.dart';
import '../specialtyscreen/SpecialtyScreen.dart';
import 'MedicalCategoryScreen.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, required this.namecategiry,required this.id}) : super(key: key);
  final String id;
  final String namecategiry;
  final CategoryController categoryController = Get.put(CategoryController());
  final ServiceController serviceController=Get.put(ServiceController());

  Future<void> _refresh() async {
    // Perform the refresh operation here
    await Future.delayed(const Duration(seconds: 3));
    categoryController.getAllCategories(id);
    serviceController.getAllServices();
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
          categoryController.getAllCategories(id);
          if (categoryController.categories.isEmpty) {

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
                      color: Colors.blue, // Placeholder color
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),


              ),
            );
          }
          else {
            return Column(
              children: [
                const SizedBox(height: 20,),
              GridView.builder(
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
                    Get.to(() => SpecialtyScreen(namespe: category.name!,id: category.id!), transition: Transition.fade);

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
                            borderRadius: BorderRadius.circular(15.0), // You can adjust the radius as needed
                            child: Image.network(
                              '${category.urlImage}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            category.name!,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                );
              },
            ),
                const SizedBox(height: 20,),


                // GridView.builder(
                //   shrinkWrap: true,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 8.0,
                //     mainAxisSpacing: 8.0,
                //   ),
                //   itemCount: serviceController.services.length,
                //   itemBuilder: (context, index) {
                //     final service = serviceController.services[index];
                //     if(service.sId=='65a821bf628565a2abc7eb01') {
                //       return GestureDetector(
                //         onTap: () async {
                //           print(service.sId);
                //           Get.to(() => MedicalCategoryScreen(namecategiry: service.name!, id: service.sId!,),
                //             transition: Transition.fade,
                //           );
                //         },
                //           child: Card(
                //             shape: const CircleBorder(),
                //             elevation: 3,
                //             color: Colors.white,
                //             margin: const EdgeInsets.symmetric(
                //                 vertical: 8, horizontal: 16),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Expanded(
                //                   child: ClipRRect(
                //                     borderRadius: BorderRadius.circular(15.0),
                //                     child: Image.network(
                //                       '${service.imageUrl}',
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(20.0),
                //                   child: Text(
                //                     service.name!,
                //                     style: const TextStyle(fontSize: 16,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //
                //       );
                //     }
                //     return null;
                //   },
                // ),

              ],

            );
          }
        }),
      ),
    );
  }
}

