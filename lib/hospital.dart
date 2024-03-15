import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hospitals {
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final List<dynamic> photoUrl; // Updated type to List<dynamic>
  final String website;

  Hospitals({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.website,
  });
}

Future<List<Hospitals>> fetchHospitals() async {
  try {
    final hospitals = await FirebaseFirestore.instance.collection('hospital').get();

    return hospitals.docs.map((doc) {
      return Hospitals(
        name: doc['hname'],
        address: doc['haddress'],
        email: doc['hemail'],
        phoneNumber: doc['hphn'],
        photoUrl: List<String>.from(doc['hphoto']), // Convert dynamic to String list
        website: doc['hweb'],
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
                final imageUrl = hospital.photoUrl.isNotEmpty ? hospital.photoUrl[0] : ''; // Get the first image URL
                return ListTile(
                  title: Text(hospital.name),
                  leading: imageUrl.isNotEmpty ? Image.network(imageUrl) : SizedBox(), // Display image if URL is not empty
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HospitalDetailsScreen(hospital: hospital)),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text('Address: ${hospital.address}'),
          Text('Email: ${hospital.email}'),
          Text('Phone: ${hospital.phoneNumber}'),
          Text('Websites: ${hospital.website}'),

        ],
      ),
    );
  }
}
