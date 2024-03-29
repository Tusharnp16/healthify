import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class EmergencyScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'In Case of Emergency',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Text(
            'Press the button below to contact emergency services.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.0),
          // ElevatedButton(
          //   onPressed: () {
          //     // Implement emergency call functionality
          //     _makeEmergencyCall(context);
          //   },
          //   child: Text('Emergency Call'),
          // ),
          Container(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color:Color.fromARGB(220, 59, 206, 255),
                  borderRadius: BorderRadius.circular(37),
                ),
                child: const Text(
                  "Emergancy",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              onPressed: () {
               _makeEmergencyCall(context);
              },
            ),
          ),
        ],
      ),
    );

  }

  void _makeEmergencyCall(BuildContext context) {
    // Implement emergency call functionality here
    // For example, you can use packages like url_launcher to initiate phone calls
    // Make sure to handle permissions and platform-specific implementations
    // Here's a basic example using url_launcher package
    // This example will launch the phone's default dialer with the emergency number
    // Replace '112' with your region's emergency number
    // For example, in the US, it's 911.
    // Also, ensure that you have added appropriate permissions in your AndroidManifest.xml and Info.plist
    // Also, import the package 'import 'package:url_launcher/url_launcher.dart';'

    final Uri _phoneCallUri = Uri(scheme: 'tel', path: '108');
    _launchURL(_phoneCallUri.toString());
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
