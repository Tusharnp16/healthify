import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthify/config/util.dart';
import 'package:healthify/navigation_menu.dart';
import 'package:image_picker/image_picker.dart';


class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  // Uint8List? _image;
  //
  // void selectimage() async {
  //   Uint8List img = await pickimage(ImageSource.gallery);
  //   setState(() {});
  //   _image = img;
  // }

  final controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return Container(
                      height: 100,
                      width: 100,
                      child: controller.image.value.path == ''
                          ? ClipOval(
                          child: Image.asset("assets/images/admin.jpg"))
                          : ClipOval(
                        child: Image.network(
                            controller.image.value.path),
                      ));
                }),
                GestureDetector(
                  child: const Text(
                    "Edit Photo",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: (){
                    controller.pickimage();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.person_2_rounded,
                      color: Colors.purple,
                    ),
                    hintText: "Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.person_2_rounded,
                      color: Colors.purple,
                    ),
                    hintText: "Gender",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.person_2_rounded,
                      color: Colors.purple,
                    ),
                    hintText: "Mobile No",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    prefixIcon: Icon(
                      Icons.person_2_rounded,
                      color: Colors.purple,
                    ),
                    hintText: "Email Id",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(37),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.uploadImageToFirebase();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationMenu()),
                    );
                  },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
