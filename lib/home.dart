import 'dart:async'; // Import for using StreamController

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthify/more.dart';
import 'bookAppointment.dart';
import 'navigation_menu.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Define a stream controller
  final StreamController<int> _controller = StreamController<int>();

  @override
  void dispose() {
    // Dispose the stream controller when not needed anymore
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String greeting = _getGreeting();
    String genderPrefix = globalGender == 'male' ? 'Mr.' : 'Mrs.';
    final screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$greeting,",
                            style: GoogleFonts.dancingScript(
                              fontSize: 20 * textScaleFactor,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$genderPrefix ${globalFName} ${globalLName}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                              child: Image.asset("assets/images/admin.jpg")))
                    ],
                  ),
                  Divider(),
                  Card(
                    elevation: 20,
                    child: Column(
                      children: [
                        Container(
                            height: 200,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(220, 174, 255, 255),
                                Color.fromARGB(220, 137, 238, 255),
                                Color.fromARGB(220, 176, 226, 255),
                                Color.fromARGB(220, 59, 206, 255),
                              ]),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 100,
                                    child: Image.asset(
                                        "assets/images/doctor.png"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Book An Appointment?",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Get consult with best doctor of your area",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                BorderRadius.circular(37),
                                              ),
                                              child: const Text(
                                                "Continue",
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              print(globalEmailID);
                                              print(globalDocID);
                                              print(globalFName);
                                              print(globalMobile);
                                              print(globalGender);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppointmentBookingPage()),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "News",
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 140,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: SizedBox.fromSize(
                                              size: Size.fromRadius(
                                                  48), // Image radius
                                              child: Image.asset(
                                                  "assets/images/Hospi.png",
                                                  fit: BoxFit.fitWidth)),
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify (tonybhai,Kamlesh & heamnt)",
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 140,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: SizedBox.fromSize(
                                              size: Size.fromRadius(
                                                  48), // Image radius
                                              child: Image.asset(
                                                  "assets/images/Hospi.png",
                                                  fit: BoxFit.fitWidth)),
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify (tonybhai,Kamlesh & heamnt)",
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 140,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: SizedBox.fromSize(
                                              size: Size.fromRadius(
                                                  48), // Image radius
                                              child: Image.asset(
                                                  "assets/images/Hospi.png",
                                                  fit: BoxFit.fitWidth)),
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify (tonybhai,Kamlesh & heamnt)",
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 140,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: SizedBox.fromSize(
                                              size: Size.fromRadius(
                                                  48), // Image radius
                                              child: Image.asset(
                                                  "assets/images/lakshadweep.jpeg",
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      const Expanded(child: Text("Tonybhai(healthify founder) going to open new branch of healthify at Lakshadweep meeting done with PM MODI",
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
          // StreamBuilder for handling stream data
          StreamBuilder<int>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              // You can use snapshot data here and return your widgets accordingly
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
