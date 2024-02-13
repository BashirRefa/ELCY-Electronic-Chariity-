import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/MatchController.dart';

class MatchScreen extends StatelessWidget {
  final MatchController matchController = Get.put(MatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matched Results'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                matchController.fetchMatchedResults();
              },
              child: Text('Fetch Matched Results'),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: matchController.matchedResults.length,
                itemBuilder: (context, index) {
                  final result = matchController.matchedResults[index];
                  return Column(
                    children: [
                      Text(result['postTitle']),
                      Text(result['content']),
                      Text(result['companyId']),
                      ElevatedButton(
                        onPressed: () async {
                          await matchController.fetchUserData(result['companyId']);
                        },
                        child: Text('Fetch Company Data'),
                      ),
                      // Show fetched user data
                      if (matchController.userData != null)
                        Column(
                          children: [
                            Text('Company Name: ${matchController.userData['name']}'),
                            Text('Company Rating: ${matchController.userData['rating']}'),
                            // Add more fields as needed
                          ],
                        ),
                      if (matchController.userData == null && matchController.isLoading.value)
                        CircularProgressIndicator(), // Show loading indicator
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
