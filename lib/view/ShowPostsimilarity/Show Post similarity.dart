import 'package:first_app/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/MatchController.dart';

class MatchScreen extends StatelessWidget {
  final MatchController matchController = Get.put(MatchController());
  Color color = const Color(0xff172F45);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        title: Text('Matched Results',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
      ),
      body: Obx(() {
        matchController.fetchMatchedResults();
        if(matchController.matchedResults.isEmpty){
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
          return ListView.builder(
            itemCount: matchController.matchedResults.length,
            itemBuilder: (context, index) {
              final result = matchController.matchedResults[index];
              matchController.fetchCompanyInfo(result.companyId);
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                          result.postTitle,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        result.content,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Name Company ${matchController.companyInfo['name']}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],
                ),
              );
            },
          );


        }
      },
      ),
    );
  }
}
