import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'razor_pay.dart';
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
  String _patientName = '';
  String _phoneNo = '';
  String _problem = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
 final RazorPay raz= new RazorPay();
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
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  void openChecF() async {
    var options = {
      'key': 'rzp_test_bsrsCz0zr14pGE',
      'amount': 20000,
      'name': 'Healthify',
      'description': 'Payment',
      'prefill': {'contact': '6352707270', 'email': 'sardakamlesh3@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(
    //     msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR HERE: ${response.code} - ${response.message}",
    //     timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET IS : ${response.walletName}",
    //     timeInSecForIosWeb: 4);
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
                  child: Text('Appointment Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
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
                  child: Text('Appointment Time: ${_selectedTime.hour}:${_selectedTime.minute}'),
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

                openChecF();

              },
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
