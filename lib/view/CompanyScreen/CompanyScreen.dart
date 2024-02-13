// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:first_app/controller/CompanyController/CompanyController.dart';
import 'package:first_app/models/Company/CompanyModel.dart';
import 'package:first_app/view/PostCompanyScreen/PostCompanyScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../NavigationBarScreen.dart';


class CompanyScreen extends StatelessWidget {
  CompanyScreen({Key? key,required this.CompanyName ,required this.id}) : super(key: key);
  final String id;
  final String CompanyName;
  final CompanyController companyController = Get.put(CompanyController());

  Future<void> _refresh()async{
    await Future.delayed(const Duration(seconds: 3),);
    companyController.getcompany(id);
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
        title: Text(CompanyName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
      ),
      body:RefreshIndicator(
        onRefresh: _refresh,
        child: Obx(() {
          companyController.getcompany(id);
          if (companyController.companies.isEmpty) {

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
          } else {

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: companyController.companies.length,
              itemBuilder: (context, index) {
                Comapny company = companyController.companies[index];
                return GestureDetector(
                  onTap: () async{

                    Get.to(PostCompanyScreen(namecpmany: company.name!,id:company.sId!,nameSp:CompanyName ),transition: Transition.fade);

                    if(company.rating!=null){
                      return Get.bottomSheet(
                        Container(
                          height: Get.height * 0.5, // Adjust the height as needed
                          width: Get.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                          ),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const  SizedBox(height: 16.0),
                              Text(

                                'Information about ${company.name}',
                                style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                              ),
                              const  SizedBox(height: 16.0),
                              Text(
                                'The Rating ${company.rating}',
                                style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                              ),
                              const  SizedBox(height: 16.0),
                              Text(
                                'Number of employees ${company.employees}',
                                style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                              ),
                              const  SizedBox(height: 16.0),
                              Text(
                                'Number of Years ${company.years}',
                                style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                              ),
                              const  SizedBox(height: 16.0),
                              Text(
                                'Number of Post ${company.NumberPost}',
                                style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                              ),

                              ElevatedButton(
                                onPressed: () {

                                  Get.back();
                                },
                                child:const Text('Close'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Card(
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child:ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.network(
                            '${company.ImgaeUrl}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ),
                        Padding(
                          padding:const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                company.name!,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),

                              Text(
                                company.rating != null ? 'the rating ${company.rating}/5' : '',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
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

