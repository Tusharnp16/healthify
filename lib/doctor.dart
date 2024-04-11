import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'doctorDetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorListPage(),
    );
  }
}

class DoctorListPage extends StatefulWidget {
  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  ViewOption _viewOption = ViewOption.listView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Doctors'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('List View'),
                value: ViewOption.listView,
              ),
              PopupMenuItem(
                child: Text('Grid View'),
                value: ViewOption.gridView,
              ),
            ],
            onSelected: (ViewOption option) {
              setState(() {
                _viewOption = option;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No doctors found.'),
            );
          }

          List<QueryDocumentSnapshot<Map<String, dynamic>>> doctorDocs = snapshot.data!.docs.map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>).toList();

          return _viewOption == ViewOption.listView
              ? _buildListView(doctorDocs)
              : _buildGridView(doctorDocs);
        },
      ),
    );
  }

  Widget _buildListView(List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        var doctorSnapshot = doctors[index];
        var doctorData = doctorSnapshot.data();
        if (doctorData == null || doctorData.isEmpty) {
          return SizedBox.shrink(); // Skip rendering empty or null data
        }
        return DoctorListItem(
          doctorData: doctorData,
          onTap: () => _navigateToDoctorDetail(doctorSnapshot),
        );
      },
    );
  }

  Widget _buildGridView(List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        var doctorSnapshot = doctors[index];
        var doctorData = doctorSnapshot.data();
        if (doctorData == null || doctorData.isEmpty) {
          return SizedBox.shrink(); // Skip rendering empty or null data
        }
        return DoctorListItem(
          doctorData: doctorData,
          onTap: () => _navigateToDoctorDetail(doctorSnapshot),
        );
      },
    );
  }

  void _navigateToDoctorDetail(QueryDocumentSnapshot<Map<String, dynamic>> doctorSnapshot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorDetailPage(doctorSnapshot: doctorSnapshot),
      ),
    );
  }
}

enum ViewOption {
  listView,
  gridView,
}

class DoctorListItem extends StatelessWidget {
  final Map<String, dynamic> doctorData;
  final VoidCallback onTap;

  const DoctorListItem({
    Key? key,
    required this.doctorData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: doctorData['imageUrl'] != null
                    ? Image.network(
                  doctorData['imageUrl'],
                  fit: BoxFit.cover,
                )
                    : Placeholder(), // Placeholder image if imageUrl is null
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                doctorData['name'] ?? 'Unknown',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
