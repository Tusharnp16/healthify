import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorDetailPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> doctorSnapshot;

  const DoctorDetailPage({Key? key, required this.doctorSnapshot}) : super(key: key);

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  late List<String> days;
  late Map<String, List<TimeOfDay?>> alarms;
  late bool isEditable;

  @override
  void initState() {
    super.initState();
    _fetchWeeklySlots();
  }

  void _fetchWeeklySlots() async {
    try {
      days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      alarms = {};

      for (String day in days) {
        final DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('doctors')
            .doc(widget.doctorSnapshot.id)
            .collection('weekly_slots')
            .doc(day)
            .get();

        if (doc.exists) {
          final List<Map<String, dynamic>> slotsData = List<Map<String, dynamic>>.from(doc['slots'] ?? []);
          final List<TimeOfDay?> slots = slotsData.map<TimeOfDay?>((slot) {
            final DateTime time = (slot['time'] as Timestamp).toDate();
            return TimeOfDay.fromDateTime(time);
          }).toList();
          alarms[day] = slots;
        } else {
          alarms[day] = [];
        }
      }
      setState(() {}); // Update UI
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    var doctorData = widget.doctorSnapshot.data();
    return Scaffold(
      appBar: AppBar(
        title: Text(doctorData['Name'] ?? 'Doctor Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(doctorData['imageUrl'] ?? ''),
                  radius: 60,
                ),
              ),
              SizedBox(height: 20),
              _buildDetailCard('Name', doctorData['name'] ?? 'Unknown'),
              _buildDetailCard('Gender', doctorData['Gender'] ?? 'Unknown'),
              _buildDetailCard('Mobile No', doctorData['contact'] ?? 'Unknown'),
              _buildDetailCard('Email Id', doctorData['Email'] ?? 'Unknown'),
              _buildDetailCard('Hospital', doctorData['Hospital'] ?? 'Unknown'),
              _buildDetailCard('Experience', '${doctorData['Experience'] ?? 'Unknown'} years'),
              _buildDetailCard('Fee', '\$${doctorData['Fee'] ?? 'Unknown'}'),
              SizedBox(height: 20),
              Text(
                'Schedule:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildSchedule(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '$label:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedule() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: days.map((day) {
          List<TimeOfDay?> slots = alarms[day] ?? [];

          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$day:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  if (slots.isNotEmpty)
                    Column(
                      children: slots.map((time) {
                        final formattedTime = DateFormat.jm().format(
                          DateTime(2022, 1, 1, time!.hour, time.minute),
                        );
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            formattedTime,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'No Schedule',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

}
