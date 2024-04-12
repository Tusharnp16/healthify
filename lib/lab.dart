import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bookAppointment.dart';

class labListPage extends StatelessWidget {
  const labListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('labs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<Hospital> hospitals = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Hospital(
              id: doc.id, // Add document ID
              name: data['name'],
              imageUrl: data['imageUrl'] ?? '', // Null check for imageUrl
              description: data['description'],
              address: data['address'],
              website: data['website'],
              email: data['email'],
              phoneNumber: data['phoneNumber'],
              location: data['location'] as GeoPoint, // Fetch location as GeoPoint
            );
          }).toList();
          return ListView.builder(
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              final hospital = hospitals[index];
              return ListTile(
                title: Text(hospital.name),
                subtitle: Text(
                  'Latitude: ${hospital.location.latitude}, Longitude: ${hospital.location.longitude}',
                ),
                leading: hospital.imageUrl.isNotEmpty
                    ? Image.network(
                  hospital.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle image loading errors
                    return Icon(Icons.error);
                  },
                )
                    : const SizedBox.shrink(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => labDetailsPage(hospital: hospital),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class labDetailsPage extends StatelessWidget {
  final Hospital hospital;

  const labDetailsPage({Key? key, required this.hospital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hospital.imageUrl.isNotEmpty)
            Image.network(
              hospital.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Handle image loading errors
                return Icon(Icons.error);
              },
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(hospital.description),
                SizedBox(height: 10),
                Text(
                  'Address:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(hospital.address),
                SizedBox(height: 10),
                Text(
                  'Website:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(hospital.website),
                SizedBox(height: 10),
                Text(
                  'Email:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(hospital.email),
                SizedBox(height: 10),
                Text(
                  'Phone Number:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(hospital.phoneNumber),
                SizedBox(height: 10),
                Text(
                  'Location:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Latitude: ${hospital.location.latitude}, Longitude: ${hospital.location.longitude}',
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => AppointmentBookingPage())));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor:
                      Color.fromARGB(255, 111, 210, 255),
                      shape: RoundedRectangleBorder(
                      ),
                    ),
                    child: Text("Continue",
                        style: TextStyle(
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Hospital {
  final String id; // Document ID
  final String name;
  final String imageUrl;
  final String description;
  final String address;
  final String website;
  final String email;
  final String phoneNumber;
  final GeoPoint location; // Location as GeoPoint

  Hospital({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.address,
    required this.website,
    required this.email,
    required this.phoneNumber,
    required this.location,
  });
}
