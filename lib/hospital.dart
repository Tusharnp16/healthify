import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hospitals {
  final String name;
  final String email;
  final String phoneNumber;
  final List<dynamic> photoUrl;
  final String website;
  final String description;
  final List<dynamic> specialties;
  final List<dynamic> history;
  final Address address;

  Hospitals({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.website,
    required this.description,
    required this.specialties,
    required this.history,
    required this.address,
  });
}

class Address {
  final List<dynamic> hAdd;
  final List<dynamic> hCity;
  final List<dynamic> hLoc; // Updated to handle GeoPoint as part of an array
  final List<dynamic> hState;

  Address({
    required this.hAdd,
    required this.hCity,
    required this.hLoc,
    required this.hState,
  });
}

Future<List<Hospitals>> fetchHospitals() async {
  try {
    final hospitals = await FirebaseFirestore.instance.collection('hospital').get();

    return hospitals.docs.map((doc) {
      return Hospitals(
        name: doc['hname'],
        email: doc['hemail'],
        phoneNumber: doc['hphn'],
        photoUrl: List<String>.from(doc['hphoto']),
        website: doc['hweb'],
        description: doc['hdescrip'],
        history: List<String>.from(doc['hhistory']),
        specialties: List<String>.from(doc['hspecial']),
        address: Address(
          hAdd: List<dynamic>.from(doc['hlocation'][0]['hadd']),
          hCity: List<dynamic>.from(doc['hlocation'][0]['hcity']),
          hLoc: List<dynamic>.from(doc['hlocation'][0]['hloc']), // Accessing GeoPoint as part of an array
          hState: List<dynamic>.from(doc['hlocation'][0]['hstate']),
        ),
      );
    }).toList();
  } catch (e) {
    print('Error fetching hospitals: $e');
    return [];
  }
}
class HospitalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals'),
      ),
      body: FutureBuilder<List<Hospitals>>(
        future: fetchHospitals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final hospitals = snapshot.data!;
            return ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                final imageUrl = hospital.photoUrl.isNotEmpty ? hospital.photoUrl[0] : '';
                final locationCount = hospital.address.hLoc.length;
                return ListTile(
                  title: Text(hospital.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Specialties',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Wrap(
                        spacing: 8.0,
                        children: hospital.specialties.map((specialty) {
                          return Chip(
                            label: Text(specialty),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Address:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('City: ${hospital.address.hCity[0]}, State: ${hospital.address.hState[0]}'),
                      SizedBox(height: 8),
                      Text(
                        'Number of Locations: $locationCount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalDetailsScreen(hospital: hospital),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class HospitalDetailsScreen extends StatelessWidget {
  final Hospitals hospital;

  HospitalDetailsScreen({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hospital.photoUrl.isNotEmpty)
              Image.network(
                hospital.photoUrl[0],
                height: 200,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            Text(
              'Email: ${hospital.email}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: ${hospital.phoneNumber}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Website: ${hospital.website}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              hospital.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Specialties:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: hospital.specialties.map((specialty) {
                return Chip(
                  label: Text(specialty),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'History:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              hospital.history.join('\n'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Text(
            //   'Address:',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 10),
            // Text('Address: ${hospital.address.hAdd[0]}, City: ${hospital.address.hCity[0]}, State: ${hospital.address.hState[0]}'),
            SizedBox(height: 20),
            Text(
              'Address:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: hospital.address.hLoc.length,
              itemBuilder: (context, index) {
                return Text(
                    '${hospital.address.hAdd[index]}, City: ${hospital.address
                        .hCity[index]}, State: ${hospital.address
                        .hState[index]} Latitude: ${hospital.address.hLoc[index]
                        .latitude}, Longitude: ${hospital.address.hLoc[index]
                        .longitude}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
