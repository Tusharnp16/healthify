import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healthify/doctor.dart';
import 'package:healthify/home.dart';
import 'package:healthify/hospital.dart';
import 'package:healthify/login.dart';
import 'package:healthify/more.dart';
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
    Doctor(),
    HospitalScreen(),// to add the Hospital page in this u have write all the field
    more()
  ];

  @override
  Widget build(BuildContext context) {
    final double iconSize = 18.0;
    final double navBarHeight = 72.0;
    final EdgeInsetsGeometry navBarPadding = EdgeInsets.zero;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(220, 59, 206, 255),
        title: const Text(
          "Healthify",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - navBarHeight,
          child: widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: navBarHeight,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: Padding(
            padding: navBarPadding,
            child: GNav(
              iconSize: iconSize,
              color: Color.fromARGB(255, 30, 30, 30),
              backgroundColor: Color.fromARGB(255, 155, 224, 255),
              activeColor: Color.fromARGB(255, 201, 93, 93),
              duration: const Duration(milliseconds: 500),
              gap: 5,
              tabs: const [
                GButton(icon: Icons.home, text: "Home"),
                GButton(icon: Icons.person, text: "Doctor"),
                GButton(icon: Icons.local_hospital_outlined, text: "Hospital"),
                GButton(icon: Icons.more_horiz_outlined, text: "Profile"),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
