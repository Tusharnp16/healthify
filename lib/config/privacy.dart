import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
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
                'Privacy Policy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(thickness: 5,),
            SizedBox(height: 10),
            Text(
              'Welcome to Healthify''s Privacy Policy.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This Privacy Policy describes how your personal information is collected, used, and shared when you use the Doctor-Patient Application.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '1. Personal Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We collect Device Information using the following technologies:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '- "Cookies" are data files that are placed on your device or computer and often include an anonymous unique identifier.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '- "Log files" track actions occurring on the Site, and collect data including your IP address, browser type, Internet service provider, referring/exit pages, and date/time stamps.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. How We Use Your Personal Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We use the Personal Information that we collect to provide and improve the Doctor-Patient Application.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '3. Sharing Your Personal Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We do not share your Personal Information with third parties.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '4. Data Retention',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We will retain your Personal Information for as long as needed to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required or permitted by law.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '5. Your Rights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'You have the right to access personal information we hold about you and to ask that your personal information be corrected, updated, or deleted.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
