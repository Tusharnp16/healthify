import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
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
      body: Center(
        child: ListView.builder(
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(faqList[index]['question'] ?? ''),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    faqList[index]['answer'] ?? '',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  final List<Map<String, String>> faqList = [
    {
      'question': 'How do I schedule an appointment?',
      'answer':
      'You can schedule an appointment by logging into your account and selecting the "Schedule Appointment" option.'
    },
    {
      'question': 'What should I bring to my appointment?',
      'answer':
      'Please bring your insurance information, any relevant medical records, and a list of current medications.'
    },
    {
      'question': 'How do I cancel an appointment?',
      'answer':
      'Yes, we take the privacy and security of your health information very seriously. Our app complies with all relevant healthcare privacy regulations and uses encryption to protect your data.'
    },
    {
      'question': 'Is my personal health information secure within the app?',
      'answer':
      'To cancel an appointment, please log into your account and select the "Cancel Appointment" option.'
    },
    {
      'question': ' Can I access the app from multiple devices?',
      'answer':
      ' Yes, you can access the app from multiple devices by logging in with your account credentials. Your account information and medical records will be synced across all devices.x'
    },
  ];
}
