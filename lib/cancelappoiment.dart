import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentListPage extends StatefulWidget {
  final String phoneNumber;

  AppointmentListPage({required this.phoneNumber});

  @override
  _AppointmentListPageState createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  late Stream<QuerySnapshot> appointmentsStream;

  @override
  void initState() {
    super.initState();
    appointmentsStream = FirebaseFirestore.instance
        .collection('appointments')
        .where('fixphn', isEqualTo: widget.phoneNumber)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: StreamBuilder(
        stream: appointmentsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var appointments = snapshot.data!.docs;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                var appointment = appointments[index];
                String patientName = appointment['Name'];
                String problem = appointment['reason'];
                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(patientName),
                    subtitle: Text(problem),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetailsPage(
                            appointment: appointment,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Center(child: Text('No appointments found'));
        },
      ),
    );
  }
}

class AppointmentDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot appointment;

  AppointmentDetailsPage({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Patient Name: ${appointment['Name']}'),
                Text('Phone Number: ${appointment['phone']}'),
                Text('Problem Faced: ${appointment['reason']}'),
                Text('History : ${appointment['past_medical_history']}'),
                Text('Date of Birth: ${appointment['dob']}'),
                Text('Gender: ${appointment['gender']}'),
                Text('Appointment Created: ${appointment['created_at']}'),
                Text('Slot Time : ${appointment['reason']}'),
                Text('Phone Used : ${appointment['fixphn']}'),
                SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    _cancelAppointment(appointment, context);
                  },
                  child: Text('Cancel Appointment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _cancelAppointment(QueryDocumentSnapshot appointment, BuildContext context) async {
    FirebaseFirestore.instance.collection('cancellation_requests').add({
      'cpatient_name': appointment['Name'],
      'cphone_number': appointment['phone'],
      'cproblem': appointment['reason'],
      'cdob': appointment['reason'],
      'cgender': appointment['gender'],
      'ccreated_at': appointment['created_at'],
      'ctimeSlot' : appointment['timeSlot'],
      if (appointment['past_medical_history'].isNotEmpty) 'cpast_medical_history': appointment['past_medical_history'],
      'creason': 'Patient canceled',
      'cpayment_status': 'pending',
      'ctimestamp': Timestamp.now(),
      'phoneused' : appointment['fixphn'],
      'cancel_by' : false,
    }).then((_) {
      appointment.reference.delete().then((_) {
        Fluttertoast.showToast(msg: 'Appointment canceled successfully');
        Navigator.pop(context);
      }).catchError((error) {
        Fluttertoast.showToast(msg: 'Failed to cancel appointment: $error');
      });
    }).catchError((error) {
      Fluttertoast.showToast(msg: 'Failed to cancel appointment: $error');
    });
  }
}