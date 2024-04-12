import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthify/Aboutus.dart';
import 'package:healthify/home.dart';
import 'package:healthify/hospital.dart';
import 'package:healthify/login.dart';
import 'package:healthify/more.dart';
import 'package:healthify/navigation_menu.dart';
import 'package:healthify/signup.dart';
import 'package:healthify/signup.dart';

void main()async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBdXfG0HI9WUnbf3iARa7rBA8IXjyjcV1M",
        appId: "1:237419669384:android:eaefe3dd13a014754ebc3d",

        messagingSenderId: "237419669384", projectId: "healthify-7e48b"),

  );
  GetStorage.init();
  await FirebaseMessaging.instance.subscribeToTopic("Healthify");
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Token $fcmToken");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),home: loginscreen(),


    );
  }
}

