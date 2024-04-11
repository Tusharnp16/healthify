import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataStream() {
    return _auth.authStateChanges().asyncExpand((User? user) {
      if (user != null) {
        return _firestore
            .collection('huser')
            .doc(user.uid)
            .snapshots(includeMetadataChanges: true);
      } else {
        // Return a stream that emits null when user is not authenticated
        return Stream.empty();
      }
    });
  }

}
uidnew() async {
  UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();

  String uid = userCredential.user!.uid;
}
class Profile extends StatelessWidget {


  final jjdhf= uidnew();



  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _firestoreService.getUserDataStream(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator
        }

        if (!snapshot.hasData) {
          return Text('No data available'); // Placeholder when data is not available
        }

        // Access the data using snapshot.data
        final userData = snapshot.data!.data();
        final String name = userData?['First Name'] ?? '';
        final String email = userData?['Email'] ?? '';
        final String mobile = userData?['Mobile'] ?? '';
        final String gender = userData?['Last Name'] ?? '';

        return Column(
          children: [
            TextFormField(
              //  decoration: InputDecoration(labelText: 'Name'),
              //    controller: TextEditingController(text: name),
              initialValue: name,
              onChanged: (value) {
                // Update name in Firestore
                // You can implement this logic if needed
              },
            ),
            TextFormField(
              //  decoration: InputDecoration(labelText: 'Email'),
              // controller: TextEditingController(text: email),
              initialValue: name,
              onChanged: (value) {
                // Update email in Firestore
                // You can implement this logic if needed
              },
            ),
            TextFormField(
              //  decoration: InputDecoration(labelText: 'Mobile'),
              initialValue: name,
              //  controller: TextEditingController(text: mobile),
              onChanged: (value) {
                // Update mobile in Firestore
                // You can implement this logic if needed
              },
            ),
            TextFormField(
              //   decoration: InputDecoration(labelText: 'Gender'),
              initialValue: name,
              //  controller: TextEditingController(text: gender),
              onChanged: (value) {
                // Update gender in Firestore
                // You can implement this logic if needed
              },
            ),
          ],
        );
      },
    );
  }
}

// Example usage:
class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Profile(),
    );
  }
}

