

import 'package:first_app/shared_preferene/cach_helper.dart';
import 'package:first_app/view/Home_screen.dart';
import 'package:first_app/view/LoginScreesn.dart';
import 'package:first_app/widgets/toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:flutter/material.dart';
import 'package:first_app/theme/theme.dart';
import 'package:get/get.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message  ');
  print(message.data.toString());
  ShowTost(text: 'on background message ', states: ToastStates.SUCCESS);

}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: "AIzaSyBajecBVuavKACli-jKBnHc5vnRKK5v6ts",
  //     appId: "1:104776519751:android:1853478b49dd525789a162",
  //     messagingSenderId: "104776519751",
  //     projectId: "finalelcy",
  //   ),
  // );
  await Firebase.initializeApp();

  var tokenFirebase = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.getInitialMessage();
  print(tokenFirebase);
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    ShowTost(text: '${event.data.toString()}', states: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.notification.toString());
    ShowTost(text: 'on message opened app ', states: ToastStates.SUCCESS);

  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CachedHelper.init();



  String? token = CachedHelper.getData(key: 'token');
  runApp(
   GetMaterialApp(
     debugShowCheckedModeBanner: false,
     locale: const Locale('ar'),
     theme: darkMode,
     home:token != null ? const HomeScreen() : LoginScreen(),
  ),
  );
}

