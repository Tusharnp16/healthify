import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppointmentBookingPage(),
    );
  }
}

class AppointmentBookingPage extends StatefulWidget {
  @override
  _AppointmentBookingPageState createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  int _lastPatientId = 0;
  String _patientName = '';
  String _phoneNo = '';
  String _selectedHospital = 'Select Hospital';
  String _selectedDoctor = 'Select Doctor';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _patientAge = 0;
  String _selectedSex = 'Male';
  String _selectedProblem = 'Select Problem';
  String _otherProblem = '';

  List<String> hospitals = ['Hospital A', 'Hospital B', 'Hospital C'];
  Map<String, List<String>> doctors = {
    'Hospital A': ['Dr. John', 'Dr. Emily'],
    'Hospital B': ['Dr. Smith', 'Dr. Olivia'],
    'Hospital C': ['Dr. James', 'Dr. Sophia'],
  };

  List<String> problemOptions = [
    'Select Problem',
    'Serious and life-threatening conditions (Heart attack, Major trauma, etc.)',
    'Acute medical conditions (Kidney stones, Broken bones, etc.)',
    'Chronic health conditions (Diabetes, Cancer, etc.)',
    'Other',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Patient ID: ${_lastPatientId + 1}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Patient Full Name'),
              onChanged: (value) {
                setState(() {
                  _patientName = value;
                });
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNo = value;
                });
              },
            ),
            SizedBox(height: 12.0),
            _selectedProblem == 'Other'
                ? TextField(
              decoration: InputDecoration(labelText: 'Enter Other Problem'),
              onChanged: (value) {
                setState(() {
                  _otherProblem = value;
                });
              },
            )
                : DropdownButtonFormField<String>(
              value: _selectedProblem,
              hint: Text('Select Problem Faced'),
              items: problemOptions.map((String problem) {
                return DropdownMenuItem<String>(
                  value: problem,
                  child: Text(problem),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedProblem = value;
                  });
                }
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _patientAge = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 12.0),
            Text(
              'Sex:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 'Male',
                  groupValue: _selectedSex,
                  onChanged: (value) {
                    setState(() {
                      _selectedSex = value.toString();
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: _selectedSex,
                  onChanged: (value) {
                    setState(() {
                      _selectedSex = value.toString();
                    });
                  },
                ),
                Text('Female'),
                Radio(
                  value: 'Other',
                  groupValue: _selectedSex,
                  onChanged: (value) {
                    setState(() {
                      _selectedSex = value.toString();
                    });
                  },
                ),
                Text('Other'),
              ],
            ),
            SizedBox(height: 12.0),
            DropdownButtonFormField<String>(
              value: _selectedHospital,
              hint: Text('Select Hospital'),
              items: ['Select Hospital', ...hospitals].map((String hospital) {
                return DropdownMenuItem<String>(
                  value: hospital,
                  child: Text(hospital),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedHospital = value;
                    if (_selectedDoctor.isNotEmpty &&
                        !doctors[_selectedHospital]!.contains(_selectedDoctor)) {
                      _selectedDoctor = 'Select Doctor';
                    }
                  });
                }
              },
            ),
            SizedBox(height: 12.0),
            _selectedHospital != 'Select Hospital'
                ? DropdownButtonFormField<String>(
              value: _selectedDoctor,
              hint: Text('Select Doctor'),
              items: ['Select Doctor', ...doctors[_selectedHospital]!].map((String doctor) {
                return DropdownMenuItem<String>(
                  value: doctor,
                  child: Text(doctor),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedDoctor = value!;
                });
              },
            )
                : SizedBox(),
            SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Appointment Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Appointment Time: ${_selectedTime.hour}:${_selectedTime.minute}',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _lastPatientId++;
                });
                print('Booking Appointment...');
                print('Patient ID: ${_lastPatientId}');
                print('Patient Name: $_patientName');
                print('Phone Number: $_phoneNo');
                print('Problem Faced: ${_selectedProblem == 'Other' ? _otherProblem : _selectedProblem}');
                print('Age: $_patientAge');
                print('Sex: $_selectedSex');
                print('Hospital: $_selectedHospital');
                print('Doctor: $_selectedDoctor');
                print('Appointment Date: $_selectedDate');
                print('Appointment Time: $_selectedTime');
              },
              child: Text('Book Appointment'),
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text('Appointment Cancelled'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Cancel Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
