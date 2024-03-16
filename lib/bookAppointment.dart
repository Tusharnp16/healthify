import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppointmentBookingPage(),
    );
  }
}

class AppointmentBookingPage extends StatefulWidget {
  const AppointmentBookingPage({Key? key}) : super(key: key);

  @override
  _AppointmentBookingPageState createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  String _patientName = '';
  String _phoneNo = '';
  String _problem = '';
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleRadioValueChanged(String? value) {
    setState(() {
      _selectedTimeSlot = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Patient Name'),
              onChanged: (value) {
                setState(() {
                  _patientName = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNo = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Problem Faced'),
              onChanged: (value) {
                setState(() {
                  _problem = value;
                });
              },
            ),
            const SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Appointment Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('Select Time Slot:'),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: '9AM-10AM',
                  groupValue: _selectedTimeSlot,
                  onChanged: _handleRadioValueChanged,
                ),
                const Text('9AM-10AM'),
                Radio<String>(
                  value: '11AM-12:30PM',
                  groupValue: _selectedTimeSlot,
                  onChanged: _handleRadioValueChanged,
                ),
                const Text('11AM-12:30PM'),
                Radio<String>(
                  value: '1:30PM-3:30PM',
                  groupValue: _selectedTimeSlot,
                  onChanged: _handleRadioValueChanged,
                ),
                const Text('1:30PM-3:30PM'),
              ],
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedTimeSlot != null && _selectedTimeSlot!.isNotEmpty) {
                  // Proceed with booking appointment
                  // Razorpay code removed
                } else {
                  // Show error message or handle empty time slot selection
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please select a time slot.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
