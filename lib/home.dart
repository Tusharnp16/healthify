

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation_menu.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Healthify",style: TextStyle(
            fontWeight: FontWeight.bold,),),
      ),
      body: Stack(children: [
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
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "KAMLESH",
                          style: TextStyle(
                              fontSize: 25,
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
                ),Divider(),
                Card(
                  elevation: 20,
                  child: Column(
                    children: [
                      Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(colors: [
                              Color(0xffe056fd),
                              Color(0xff9402b6),
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
                                  child: Image.asset("assets/images/doctor.png"),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Book An Appoiment?",
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NavigationMenu()),
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
                                            child: Image.asset("assets/images/Hospi.png",fit: BoxFit.fitWidth)
                                        ),
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
                                            child: Image.asset("assets/images/Hospi.png",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify tonybhai",
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
                                            child: Image.asset("assets/images/Hospi.png",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify tonybhai",
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
                                            child: Image.asset("assets/images/Hospi.png",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify tonybhai",
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
