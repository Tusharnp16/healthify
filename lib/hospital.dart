import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthify/more.dart';
import 'bookAppointment.dart';
import 'navigation_menu.dart';

class hospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                const Text(
                  "Hospital",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/ShalbyHospital.jpg",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("Shalby Hospital",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/sunshinegobalhospital.jpg",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("Sunshinegobalhospital",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/Nirmal-Hospital.jpg",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("Nirmal Hospital",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/kiranHospital.jpg",fit: BoxFit.fill)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("Kiran Hospital",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
