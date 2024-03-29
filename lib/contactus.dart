import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ContactForm(),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircularTextField(
            key: UniqueKey(),
            // Example of providing a unique key
            controller: _nameController,
            labelText: 'Your Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16.0),
          CircularTextField(
            controller: _emailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              if (!value!.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
            key: UniqueKey(),
          ),
          SizedBox(height: 16.0),

          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide( color : Color.fromARGB(255, 111, 210, 255), width: 5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color : Color.fromARGB(255, 111, 210, 255), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Color.fromARGB(255, 148, 148, 148), width: 2.0),
              ),
            ),
            maxLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: Color.fromARGB(255, 111, 210, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33.3 * textScaleFactor),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submitForm();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    // Here, you can implement logic to store the form data in a database
    String name = _nameController.text;
    String email = _emailController.text;
    String message = _messageController.text;

    // Example: Print the form data
    print('Name: $name');
    print('Email: $email');
    print('Message: $message');

    // After submitting, you can clear the form
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();

    // Show a success message or navigate to another page
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text('Form submitted successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class CircularTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;

  const CircularTextField({
    required Key key,
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
