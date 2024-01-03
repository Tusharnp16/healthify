import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healthify/doctor.dart';
import 'package:healthify/home.dart';
import 'package:healthify/hospital.dart';
import 'package:healthify/login.dart';
import 'package:healthify/profile.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});
  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    home(),
    doctor(),
    hospital(),
    profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:Center(
        child: widgetOptions.elementAt(_selectedIndex),
    ),
      bottomNavigationBar:
      Container(
        margin: EdgeInsets.symmetric(vertical: 15,horizontal: 5),
        child: Padding(
          padding: EdgeInsets.zero,
                      child: GNav(
                            color: Colors.black,
                            backgroundColor: Colors.white60,
                            tabBackgroundColor: Colors.purpleAccent,
                            activeColor: Colors.black,
                            duration: Duration(milliseconds: 500),
                            gap: 8,
                           tabActiveBorder: Border.all(color: Colors.black, width: 2), // tab button border
                            tabs: const [
                              GButton(icon: Icons.home,text: "Home",),
                              GButton(icon: Icons.local_hospital_outlined,text: "Hospital"),
                              GButton(icon: Icons.person,text: "Doctor"),
                              GButton(icon: Icons.more_horiz_outlined,text: "Profile"),
                            ],
                            selectedIndex: _selectedIndex,
                            onTabChange: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            }
                          ),
                  ),
      ),
        );
  }
}

