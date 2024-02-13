// ignore_for_file: must_be_immutable

import 'package:first_app/controller/PostController/PostController.dart';
import 'package:first_app/models/PostModel/PostModel.dart';
import 'package:first_app/view/PostCompanyScreen/ShowPost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../NavigationBarScreen.dart';

class PostCompanyScreen extends StatelessWidget {
  PostCompanyScreen({Key? key, required this.namecpmany, required this.id,required this.nameSp}) : super(key: key);

  final String id;
  final String namecpmany;
  final String nameSp;
  final PostController postController = Get.put(PostController());
  Color color = const Color(0xff172F45);

  Future<void> _refresh() async {
    // Perform the refresh operation here
    await Future.delayed(const Duration(seconds: 3));
    postController.getAllPosts(id);

  }
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
        child: Obx(() {
          postController.getAllPosts(id);
          if (postController.posts.isEmpty) {
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
            // Display the list of posts
            return Padding(
                padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                itemCount: postController.posts.length,
                itemBuilder: (context, index) {
                  Post post = postController.posts[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        print(post.sId);
                        // Get.to(SpecialtyScreen(id: category.id!,), transition: Transition.fade);
                        Get.to(ShowPostScreen(namecpmany: namecpmany, post: post,nameSp: nameSp,));
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(post.title ?? ''),
                            //subtitle: Text(post.content ?? ''),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}