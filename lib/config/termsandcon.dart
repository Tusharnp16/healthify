import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(thickness: 5,),
            SizedBox(height: 16),
            Text(
              'Welcome to Healthify.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please read these terms and conditions carefully before using the application.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'These terms and conditions govern your use of the Doctor-Patient Application. By using this application, you accept these terms and conditions in full. If you disagree with these terms and conditions or any part of these terms and conditions, you must not use this application.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. License to use application',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Unless otherwise stated, Doctor-Patient Application and/or its licensors own the intellectual property rights in the application and material on the application. Subject to the license below, all these intellectual property rights are reserved.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '3. Acceptable use',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'You must not use this application in any way that causes, or may cause, damage to the application or impairment of the availability or accessibility of the application; or in any way which is unlawful, illegal, fraudulent or harmful, or in connection with any unlawful, illegal, fraudulent or harmful purpose or activity.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '4. User account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'In order to use this application, you may be required to create a user account and provide personal information. You agree to provide accurate, current and complete information during the registration process and to update such information to keep it accurate, current and complete. You are responsible for maintaining the confidentiality of your account and password, and for restricting access to your account. You agree to accept responsibility for all activities that occur under your account or password.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '5. Privacy policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'By using this application, you consent to the collection, use and disclosure of your personal information in accordance with our Privacy Policy.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
