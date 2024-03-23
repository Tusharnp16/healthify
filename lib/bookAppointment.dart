import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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
  String _patientName = '';
  String _phoneNo = '';
  String _problem = '';
  String _selectedDoctor = '';
  String _selectedSlot = '';
  DateTime _selectedDate = DateTime.now();
  DateTime? _selectedDOB;
  String _selectedGender = '';
  final Razorpay _razorpay = Razorpay();
  CollectionReference appointments = FirebaseFirestore.instance.collection('appointmentsd');
  CollectionReference doctors = FirebaseFirestore.instance.collection('doctor');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_bsrsCz0zr14pGE',
      'amount': 50000,
      'name': 'Healthify',
      'description': 'Payment',
      'prefill': {'contact': '6352707270', 'email': 'sardakamlesh3@gmail.com'},
      'external': {'wallets': ['paytm']}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
    // Create and save receipt upon successful payment
    File pdfFile = await _createReceipt();
    // Navigate to PdfViewScreen to display the PDF
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewScreen(pdfFile: pdfFile),
      ),
    );
    // Show notification for receipt download
    _showNotification();
  }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(msg: "ERROR HERE: ${response.code} - ${response.message}", timeInSecForIosWeb: 4);
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(msg: "EXTERNAL_WALLET IS : ${response.walletName}", timeInSecForIosWeb: 4);
  // }

  Future<List<String>> _getDoctorSlotsForDate(String selectedDoctor, DateTime selectedDate) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('doctor').doc(selectedDoctor).get();
      if (snapshot.exists) {
        Map<String, dynamic> availability = snapshot.data()!['davail'];
        String dayOfWeek = DateFormat('EEEE').format(selectedDate);
        String dayKey = '';
        switch (dayOfWeek) {
          case 'Monday':
            dayKey = 'damon';
            break;
          case 'Tuesday':
            dayKey = 'datue';
            break;
          case 'Wednesday':
            dayKey = 'dawed';
            break;
          case 'Thursday':
            dayKey = 'dathu';
            break;
          case 'Friday':
            dayKey = 'dafri';
            break;
          case 'Saturday':
            dayKey = 'dasat';
            break;
          case 'Sunday':
            dayKey = 'dasun';
            break;
          default:
          // Handle invalid day
            break;
        }
        List<String> slots = availability[dayKey]?.cast<String>() ?? [];
        return slots;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching slots: $e');
      return [];
    }
  }

  Future<File> _createReceipt() async {
    // Create receipt with appointment details
    String fileName = 'appointment_receipt.pdf';

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(
            'Appointment Receipt\n\n'
                'Patient Name: $_patientName\n'
                'Phone Number: $_phoneNo\n'
                'Problem Faced: $_problem\n'
                'Selected Doctor: $_selectedDoctor\n'
                'Selected Slot: $_selectedSlot\n'
                'Appointment Date: ${DateFormat('EEEE, MMM d, yyyy').format(_selectedDate)}\n'
                'Date of Birth: ${_selectedDOB != null ? DateFormat('yyyy-MM-dd').format(_selectedDOB!) : ''}\n'
                'Gender: $_selectedGender\n'
                'Age: ${_selectedDOB != null ? _calculateAge(_selectedDOB!) : ''}\n',
            style: pw.TextStyle(fontSize: 20),
          ),
        ),
      ),
    );

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    Fluttertoast.showToast(msg: "Receipt downloaded successfully", timeInSecForIosWeb: 4);
    return file;
  }

  int _calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  void _showNotification() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Successful"),
          content: Text("Receipt has been generated successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }



    void _showNotificationDownload() async {
  var android = AndroidNotificationDetails(
      'channelId', 'channelName', priority: Priority.high, importance: Importance.max);
  var platform = NotificationDetails(android: android);
  await flutterLocalNotificationsPlugin.show(
      0, 'Receipt Downloaded', 'Your receipt has been downloaded', platform,
      payload: '');
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
        TextField(
        decoration: InputDecoration(labelText: 'Patient Name'),
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
      TextField(
        decoration: InputDecoration(labelText: 'Problem Faced'),
        onChanged: (value) {
          setState(() {
            _problem = value;
          });
        },
      ),
      SizedBox(height: 12.0),
      Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Date of Birth'),
              readOnly: true,
              controller: TextEditingController(
                  text: _selectedDOB != null
                      ? DateFormat('yyyy-MM-dd').format(_selectedDOB!)
                      : ''),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDOB ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != _selectedDOB) {
                  setState(() {
                    _selectedDOB = picked;
                  });
                }
              },
            ),
          ),
          SizedBox(width: 12.0),

        ],
      ),

      SizedBox(height: 12.0),
         Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gender'),
          Row(
            children: [
              Radio<String>(
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              Text('Male'),
              Radio<String>(
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              Text('Female'),
              Radio<String>(
                value: 'Other',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              Text('Other'),
            ],
          ),
        ],
      ),

      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          List<DropdownMenuItem> doctorDropdownItems = [];
          for (var Users in snapshot.data!.docs) {
            String doctorName = Users.get('Name');
            doctorDropdownItems.add(
              DropdownMenuItem(
                child: Text(doctorName),
                value: doctorName,
              ),
            );
          }
          return Row(
            children: <Widget>[
              Expanded(
                child: DropdownButton(
                  items: doctorDropdownItems,
                  onChanged: (value) async {
                    setState(() {
                      _selectedDoctor = value.toString();
                      _selectedSlot = '';
                    });
                    // Refresh slots dropdown
                    setState(() {});
                  },
                  value: _selectedDoctor.isNotEmpty ? _selectedDoctor : null,
                  hint: Text('Select Doctor'),
                ),
              ),
            ],
          );
        },
      ),
      SizedBox(height: 12.0),
      // Date selection
      Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Appointment Date: ${DateFormat('EEEE, MMM d, yyyy').format(_selectedDate)}',
            ),
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select Date'),
          ),
        ],
      ),
      SizedBox(height: 12.0),
      if (_selectedDoctor.isNotEmpty)
  StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance.collection('doctor').doc(_selectedDoctor).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return CircularProgressIndicator();
      if (!snapshot.data!.exists) return Text('No data found');
      Map<String, dynamic>? availability = (snapshot.data! as DocumentSnapshot<Map<String, dynamic>>).data()?['davail'];

      if (availability == null || availability.isEmpty) {
        return Text('No slots available');
      } else {
        String dayOfWeek = DateFormat('EEEE').format(_selectedDate);
        String dayKey = '';
        switch (dayOfWeek) {
          case 'Monday':
            dayKey = 'damon';
            break;
          case 'Tuesday':
            dayKey = 'datue';
            break;
          case 'Wednesday':
            dayKey = 'dawed';
            break;
          case 'Thursday':
            dayKey = 'dathu';
            break;
          case 'Friday':
            dayKey = 'dafri';
            break;
          case 'Saturday':
            dayKey = 'dasat';
            break;
          case 'Sunday':
            dayKey = 'dasun';
            break;
          default:
          // Handle invalid day
            break;
        }
        List<String> slots = availability[dayKey]?.cast<String>() ?? [];
        return DropdownButtonFormField(
          value: _selectedSlot,
          hint: Text('Select Slot'),
          items: slots.map((slot) {
            return DropdownMenuItem<String>(
              value: slot,
              child: Text(slot),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedSlot = value!;
            });
          },
        );
      }
    },
  ),
  SizedBox(height: 12.0),
  ElevatedButton(
  onPressed: () {
  // Check if all fields are filled
  if (_patientName.isNotEmpty &&
  _phoneNo.isNotEmpty &&
  _problem.isNotEmpty &&
  _selectedDoctor.isNotEmpty &&
  _selectedDOB != null &&
  _selectedGender.isNotEmpty) {
  // Generate a unique user_id
  String userId = DateTime.now().millisecondsSinceEpoch.toString();
  // Insert data into Firestore
  appointments.add({
  'doctor_id': _selectedDoctor, // Reference to doctor_id
  'user_id': userId,
    'Name ':_patientName,
  'status': 'pending',
  'reason': _problem,
  'appointment_slot': _selectedSlot,
  'dob': _selectedDOB,
  'gender': _selectedGender,
  'created_at': Timestamp.now(),
  }).then((_) {
    openCheckout();

  // Appointment booked successfully
  Fluttertoast.showToast(msg: 'Appointment booked successfully');
  // Initiating payment

  }).catchError((error) {
  // Error occurred while booking appointment
    // Error occurred while booking appointment
    Fluttertoast.showToast(msg: 'Failed to book appointment: $error');
  });

  } else {
    Fluttertoast.showToast(msg: 'Please fill all fields');
  }
  },
    child: Text('Book Appointment'),
  ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _downloadReceipt,
                child: Text('Download Receipt'),
              ),
            ],
        ),
      ),
  );
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

Future<void> _downloadReceipt() async {
  // Create and save the receipt
  await _createReceipt();
  // Show notification for download
  _showNotificationDownload();
}
}

class PdfViewScreen extends StatelessWidget {
  final File pdfFile;

  PdfViewScreen({required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Receipt'),
      ),
      body: Center(
        child: PDFView(
          filePath: pdfFile.path, // Use the path of the File object
        ),
      ),
    );
  }
}

