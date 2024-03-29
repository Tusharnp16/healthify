import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'config/util.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  final String userId;
  String? phn=globalPhoneNumber?.substring(3);

  Profile({required this.userId});z
  final controller = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Patient')
            .doc(userId) // Assuming 'users' is the collection name
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Or any other loading indicator
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Text('No data found for this user.');
          }

          // Explicitly cast the data to Map<String, dynamic>
          var userData = snapshot.data!.data() as Map<String, dynamic>;

          // Access user data
          var name = userData['First Name'] as String?;
          var email = userData['Email'] as String?;
          var mobile = userData['Mobile'] as String?;
          var last = userData['Last name'] as String?;


          return SingleChildScrollView(
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
                          child: Image.asset(
                              "assets/images/admin.jpg"))
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
                  onTap: () {
                    controller.pickimage();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: name,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
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
                TextFormField(
                  initialValue: last,
                  readOnly: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
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
                TextFormField(
                  readOnly: true,
                  initialValue: mobile,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
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
                TextFormField(
                  readOnly: true,
                  initialValue: email,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
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

                // CupertinoButton(
                //   padding: EdgeInsets.zero,
                //   child: Container(
                //     alignment: Alignment.center,
                //     width: double.infinity,
                //     height: 40,
                //     decoration: BoxDecoration(
                //       color: Colors.purpleAccent,
                //       borderRadius: BorderRadius.circular(37),
                //     ),
                //     child: const Text(
                //       "Edit Profile",
                //       style: TextStyle(
                //         color: Colors.black87,
                //         fontWeight: FontWeight.w700,
                //       ),
                //     ),
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => Profile()),
                //     );
                //   },
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
