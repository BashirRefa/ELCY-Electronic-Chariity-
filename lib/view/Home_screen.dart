
import 'package:first_app/controller/ServicesController/ServicesController.dart';
import 'package:first_app/view/Category/CategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'Category/MedicalCategoryScreen.dart';
import 'NavigationBarScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {


  final ServiceController serviceController = Get.put(ServiceController());
  AnimationController? animationController;
  Animation? fadingAnimation;

    Color color = const Color(0xff172F45);

  Future<void> _refresh() async {

    await Future.delayed(const Duration(seconds: 3));
     serviceController.getAllServices();

  }

  @override
  void initState() {
    serviceController.getAllServices();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    fadingAnimation = Tween<double>(begin: .2, end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  Widget _title() {
    return AnimatedBuilder(
      animation: fadingAnimation!,
      builder: (context, _) => Opacity(
        opacity: fadingAnimation?.value,
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              text: 'ELCY',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),

          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavigationBarScreen(),
      backgroundColor: color,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title(),
            Image.asset('assets/images/Login.png',scale: 6,),
          ],
        ),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Obx(() {
          serviceController.getAllServices();
          if (serviceController.services.isEmpty) {
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
              itemCount: serviceController.services.length,
              itemBuilder: (context, index) {
                final service = serviceController.services[index];
                return GestureDetector(
                  onTap: () async {

                    if(service.sId=='65ce653972fe6d012d6c8840' || service.sId=='65ce654d72fe6d012d6c8ab2'){
                      return Get.to(() => MedicalCategoryScreen(namecategiry: service.name!, id: service.sId!,),
                        transition: Transition.fade,
                      );


                    }else{
                      Get.to(
                            () => CategoryScreen(
                          namecategiry: service.name!,
                          id: service.sId!,
                        ),
                        transition: Transition.fade,
                      );
                    }

                  },
                  child: Card(
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.network(
                              '${service.imageUrl}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            service.name!,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
