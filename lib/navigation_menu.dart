// /*
// import 'dart:ffi';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:healthify/login.dart';
//
// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//
//    return Scaffold(
//      bottomNavigationBar: Obx(
//          ()=>NavigationBar(
//            height: 80,
//            elevation: 0,
//            selectedIndex: controller.selectedindex.value,
//            onDestinationSelected: (index) => controller.selectedindex.value=index,
//            destinations: const[
//              NavigationDestination(icon: Icon(CupertinoIcons.home), label: "Home"),
//              NavigationDestination(icon: Icon(Icons.local_hospital_outlined), label: "Hospital"),
//              NavigationDestination(icon: Icon(Icons.person_2_outlined), label: "Doctor"),
//              NavigationDestination(icon: Icon(Icons.more_horiz), label: "More")
//            ],
//          )
//      ),
//      body: Obx(() => controller.screens[controller.selectedindex.value]),
//    );
//   }
//
// }
//
// class NavigationController extends GetxController{
//   final Rx<int> selectedindex=0
//
//       final screens=[Container(color: Colors.purple,),Container(color: Colors.green,),Container(color: Colors.red,),Container(color: Colors.yellow,)]
// }*/
