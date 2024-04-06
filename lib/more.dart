import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthify/ambulance.dart';
import 'package:healthify/faq.dart';
import 'package:healthify/login.dart';
import 'package:healthify/logout.dart';
import 'package:healthify/feedback.dart';
import 'package:healthify/contactus.dart';
import 'package:healthify/emergancy.dart';
import 'package:healthify/profilenew.dart';
import 'chatbot.dart';
import 'package:healthify/Aboutus.dart';
import 'package:healthify/profile.dart';

import 'config/privacy.dart';
import 'config/termsandcon.dart';


class more extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(2),
              child: ListTile(
                  title: Text("Profile"),
                  trailing: ClipOval(
                    // Image radius
                    child: Image.asset('assets/images/admin.jpg',
                        fit: BoxFit.cover),
                  ),
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfileScreen()));}

              ),
            ),
            Divider(),
            ListTile(
              title: Text("ChatBot"),
              trailing: Icon(Icons.chat),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreenPage()));
              },),
            ListTile(
              title: Text("Ambulance"),
              trailing: Icon(Icons.emergency_share_rounded),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AmbulanceScreen()));
              },),
            ListTile(
              title: Text("Emergancy"),
              trailing: Icon(Icons.emergency),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EmergencyScreenBody()));
              },),
            ListTile(
              title: Text("Appoiment"),
              trailing: Icon(Icons.app_registration),
              onTap: () => print("We are working on it Tonybhai"),
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> logout()));
            ),
            ListTile(
              title: Text("Feedback"),
              trailing: Icon(Icons.feedback_outlined),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FeedbackScreen()));
              },
            ),
            ListTile(
              title: Text("Contact Us"),
              trailing: Icon(Icons.contact_page_outlined),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUsPage()));
              },//Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactForm()));
            ),
            Divider(),
            ListTile(
              title: Text("FAQs"),
              trailing: Icon(Icons.question_mark),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FAQ()));
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              trailing: Icon(Icons.privacy_tip),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  PrivacyPolicyPage()),
                );
                // Navigate to privacy policy page
              },
            ),
            ListTile(
              title: const Text('Terms of Service'),
              trailing: Icon(Icons.private_connectivity_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  TermsAndConditionsPage()),
                );
                // Navigate to terms of service page
              },
            ),
            ListTile(
              title: Text("About Healthify"),
              trailing: Icon(Icons.local_hospital_outlined),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Aboutus()));
              },
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> logout()));
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> loginscreen()));
              },
            ),
          ],
        )
    );
  }
}