import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthify/home.dart';
import 'package:healthify/navigation_menu.dart';
import 'package:flutter/cupertino.dart';

class loginscreen extends StatelessWidget{
  const loginscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffe056fd),
                Color(0xff9402b6),
              ]),
            ),
            child: const Padding(padding: EdgeInsets.only(top:60.0, left: 22),
              child: Text("Welcome Back !!,\nSign In",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),),),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(padding: const EdgeInsets.only(left: 18.0,right: 18),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30,left:8,right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                              prefixIcon: Icon(Icons.person_2_rounded,color: Colors.purple,),
                              hintText: "Gmail",
                          ),
                        ),
                      const SizedBox(height : 20),
                     const TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                              prefixIcon: Icon(Icons.lock_open,color: Colors.purple,),
                              border: InputBorder.none,
                            hintText: "Password",
                          ),
                        ),
                        const SizedBox(height: 30,),
                      Container(
                        child: CupertinoButton(
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
                              "Continue",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const NavigationMenu()),);
                          },
                        ),
                      ),
                        const SizedBox(height: 10,),
                        const Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Don't Register Yet? ",style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                            ),), Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.red),),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text("---Or Log In---",
                          style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                                width : 50,
                                height: 50,
                                child: Image.asset('assets/images/fblogo.png')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width : 50,
                                height: 50,
                                child: Image.asset('assets/images/instagram.png')),
                          ),
                           Container(
                              width : 50,
                              height: 50,
                              child: Image.asset('assets/images/mobile-phone.png')),

                        ],

                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}