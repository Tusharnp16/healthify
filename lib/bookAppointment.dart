import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Payment Success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment Error: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('External Wallet: ${response.walletName}');
  }

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

  void _handlePayment() {
    // Replace with your Razorpay API key
    String apiKey = 'YOUR_RAZORPAY_API_KEY';
    var options = {
      'key': apiKey,
      'amount': 100, // Change this to the actual amount in paise
      'name': 'Appointment Booking',
      'description': 'Payment for Appointment Booking',
      'prefill': {'contact': _phoneNo, 'email': 'example@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
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
              items: problemOptions.map<DropdownMenuItem<String>>((String problem) {
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
              items: ['Select Hospital', ...hospitals].map<DropdownMenuItem<String>>((String hospital) {
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
              items: ['Select Doctor', ...doctors[_selectedHospital]!]
                  .map<DropdownMenuItem<String>>((String doctor) {
                return DropdownMenuItem<String>(
                  value: doctor,
                  child: Text(doctor),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedDoctor = value;
                  });
                }
              },
            )
                : SizedBox.shrink(),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Select Date:'),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                      '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Select Time:'),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                      '${_selectedTime.hour}:${_selectedTime.minute}'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handlePayment,
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
