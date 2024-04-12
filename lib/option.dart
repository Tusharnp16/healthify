
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthify/hospital.dart';

import 'doctor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                  children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HospitalListPage()));
                },
                icon: Image.asset("assets/images/hospital.jpg")),
                    const Text(
                      "Hospitals",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

            
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => DoctorListPage()));
                },
                icon: Image.asset("assets/images/lab.jpg")),
                    const Text(
                      "Lab",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => DoctorListPage()));
                        },
                        icon: Image.asset("assets/images/lab.jpg")),
                    const Text(
                      "Lab",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
            
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => DoctorListPage()));
                },
                icon: Image.asset("assets/images/phsio.jpeg")),
                    const Text(
                      "Phsio",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
          ),
        ));
  }
}


