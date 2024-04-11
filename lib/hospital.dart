import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HospitalListPage extends StatelessWidget {
  const HospitalListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
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
            );
          }).toList();
          return ListView.builder(
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              final hospital = hospitals[index];
              return ListTile(
                title: Text(hospital.name),
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
                      builder: (context) => HospitalDetailsPage(hospital: hospital),
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

class HospitalDetailsPage extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailsPage({Key? key, required this.hospital}) : super(key: key);

  Future<void> _deleteHospital(BuildContext context) async {
    try {
      bool deleteConfirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Hospital?'),
          content: Text('Are you sure you want to delete ${hospital.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // Cancel deletion
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Confirm deletion
              },
              child: Text('Delete'),
            ),
          ],
        ),
      );

      if (deleteConfirmed != null && deleteConfirmed) {
        await FirebaseFirestore.instance.collection('hospitals').doc(hospital.id).delete(); // Use document ID
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hospital deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

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
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _deleteHospital(context),
            child: Text('Delete'),
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

  Hospital({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.address,
    required this.website,
    required this.email,
    required this.phoneNumber,
  });
}
