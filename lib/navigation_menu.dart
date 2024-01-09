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
      SizedBox(
        height: 80,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
          child: Padding(
            padding: EdgeInsets.zero,
                        child: GNav(
                            iconSize: 20,
                             tabBorder: Border.all(color: Colors.grey, width: 1),
                              color: Colors.black,
                              backgroundColor: Colors.white60,
                              tabBackgroundColor: Colors.purpleAccent,
                              activeColor: Colors.black,
                              duration: Duration(milliseconds: 500),
                              gap: 5,
                             tabActiveBorder: Border.all(color: Colors.black, width: 2), // tab button border
                              tabs: const [
                                GButton(icon: Icons.home,),
                                GButton(icon: Icons.local_hospital_outlined,),
                                GButton(icon: Icons.person,),
                                GButton(icon: Icons.more_horiz_outlined,),
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
      ),
        );
  }
}

