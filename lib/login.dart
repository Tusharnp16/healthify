import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthify/navigation_menu.dart';
import 'package:healthify/signup.dart';
import 'package:lottie/lottie.dart';

class loginscreen extends StatelessWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(220, 174, 255, 255),
                Color.fromARGB(220, 137, 238, 255),
                Color.fromARGB(220, 176, 226, 255),
                Color.fromARGB(220, 59, 206, 255),
              ]),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.12),
                      child: Row(
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(28.0, -21.0, 0.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Opacity(
                                    opacity: 0.6,
                                    child: Transform(
                                      transform: Matrix4.translationValues(-4.5, -28.8, 0.0),
                                      child: Lottie.asset(
                                        'assets/Video/anime.json',
                                        fit: BoxFit.cover,
                                        height: screenSize.height * 0.135,
                                        width: screenSize.height * 0.135,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 9.0),
                                Text(
                                  "Welcome Back !!,\nSign In",
                                  style: TextStyle(
                                    fontSize: 27 * textScaleFactor,
                                    color: Color.fromARGB(255, 72, 72, 72),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center( // Wrap with Center widget to move the container to the center
                      child: Container(
                        width: screenSize.width, // Adjust the width of the container as needed
                        height: screenSize.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.2 * textScaleFactor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 9.0 * textScaleFactor),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                                    borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                                    borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                                  ),
                                  prefixIcon: Icon(Icons.person_2_rounded, color: Color.fromARGB(220, 59, 206, 255),
                                      size: 21.6* textScaleFactor),
                                  hintText: "Gmail",
                                ),
                              ),
                              SizedBox(height: 18 * textScaleFactor),
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 9.0 * textScaleFactor),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                                    borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                                    borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                                  ),
                                  prefixIcon: Icon(Icons.lock_open, color: Color.fromARGB(220, 59, 206, 255), size: 21.6 * textScaleFactor),
                                  hintText: "Password",
                                ),
                              ),
                              SizedBox(height: 27 * textScaleFactor),
                              Container(
                                width: double.infinity,
                                height: 36 * textScaleFactor,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NavigationMenu()),);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black87,
                                    backgroundColor:Color.fromARGB(
                                        255, 111, 210, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(33.3 * textScaleFactor),
                                    ),
                                  ),
                                  child:  Text("Continue", style: TextStyle(fontSize: 16.2 * textScaleFactor,)),
                                ),
                              ),
                              SizedBox(height: 22.5 * textScaleFactor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      endIndent: 4.5 * textScaleFactor,
                                    ),
                                  ),
                                  Text("Or Continue with",
                                    style: TextStyle(
                                      fontSize: 16.2 * textScaleFactor,
                                      color: Color.fromARGB(255, 72, 72, 72),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      indent: 4.5 * textScaleFactor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 27 * textScaleFactor,
                                    height: 27 * textScaleFactor,
                                    child: Image.asset("assets/images/goog.png"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(7.2 * textScaleFactor),
                                    child: Container(
                                      width: 27 * textScaleFactor,
                                      height: 27 * textScaleFactor,
                                      child: Image.asset("assets/images/instagram.png"),
                                    ),
                                  ),
                                  Container(
                                    width: 27 * textScaleFactor,
                                    height: 27 * textScaleFactor,
                                    child: Image.asset('assets/images/phone.png'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9 * textScaleFactor),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 9 * textScaleFactor),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.5 * textScaleFactor, vertical: 9 * textScaleFactor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ", style: TextStyle(
                            fontSize: 13.5 * textScaleFactor,
                            color: Colors.black87,
                          ),),
                          GestureDetector(
                            child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 13.5 * textScaleFactor,
                              color: Colors.red,
                            ),),
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  Signup()),);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
