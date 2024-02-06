import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:mask_text_formatter/mask_text_formatter.dart';

import 'login.dart';



class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class TenDigitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return formatEditValue(oldValue, newValue);
  }

  @override
  TextEditingValue formatEditValue(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 10) {
      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(offset: oldValue.text.length),
      );
    }
    return newValue;
  }
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // TextEditingController _phoneNumberController = TextEditingController();


  TextEditingController _nameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();

  String? _nameErr;
  String? _lnameErr;
  String? _emailErr;
  String? _passwordErr;
  String? _confirmPasswordErr;
  String? _phoneNumberErr;

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffe056fd), Color(0xff9402b6)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                "Welcome Back !!,\nSign In",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 8, right: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTextInput(
                            controller: _nameController,
                            onChanged: _validateName,
                            hintText: "First Name",
                            errorText: _nameErr,
                            icon: Icons.person_3_rounded,
                          ),
                          const SizedBox(height: 20),

                          _buildTextInput(
                            controller: _lnameController,
                            onChanged: _validateLastName,
                            hintText: "Last Name",
                            errorText: _lnameErr,
                            icon: Icons.person_3_rounded,
                          ),
                          const SizedBox(height: 20),

                          _buildPhoneNumberField(),

                          const SizedBox(height: 20),
                          _buildTextInput(
                            controller: _emailController,
                            onChanged: _validateEmail,
                            hintText: "Email",
                            errorText: _emailErr,
                            icon: Icons.mail,
                          ),

                          const SizedBox(height: 20),
                          _buildPasswordField(
                            controller: _passwordController,
                            onChanged: _validatePassword,
                            hintText: "Password",
                            errorText: _passwordErr,
                            icon: Icons.lock_open,
                            isHidden: _isPasswordHidden,
                            onPressed: _togglePasswordVisibility,
                          ),
                          const SizedBox(height: 20),
                          _buildPasswordField(
                            controller: _confirmPasswordController,
                            onChanged: _validateConfirmPassword,
                            hintText: "Confirm Password",
                            errorText: _confirmPasswordErr,
                            icon: Icons.lock_open,
                            isHidden: _isConfirmPasswordHidden,
                            onPressed: _toggleConfirmPasswordVisibility,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _validateAndNavigate,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(37),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 5,
            right: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already Have An Account? ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const loginscreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return InternationalPhoneNumberInput(
      onInputChanged: _validatePhoneNumber,
      onInputValidated: (bool value) {
        // Handle validation state
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        // initialCountryIsoCode: 'IN', // Set default country to India
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      formatInput: false,
      keyboardType: TextInputType.phone,
      inputBorder: _inputBorderStyle(),
      errorMessage: _phoneNumberErr,
      hintText: 'Phone Number',
      initialValue: PhoneNumber(isoCode: 'IN'),
      // ... other code
    );
  }


  Widget _buildTextInput({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hintText,
    required String? errorText,
    required IconData icon,
  }) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: _inputBorderStyle(),
        focusedBorder: _inputBorderStyle(),
        prefixIcon: Icon(icon, color: Colors.purple),
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hintText,
    required String? errorText,
    required IconData icon,
    required bool isHidden,
    required VoidCallback onPressed,
  }) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: isHidden,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: _inputBorderStyle(),
        focusedBorder: _inputBorderStyle(),
        prefixIcon: Icon(icon, color: Colors.purple),
        suffixIcon: IconButton(
          icon: Icon(
            isHidden ? Icons.visibility : Icons.visibility_off,
            color: Colors.purple,
          ),
          onPressed: onPressed,
        ),
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }

  OutlineInputBorder _inputBorderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }

  void _validateName(String value) {
    setState(() {
      // Validation logic for the first name
      _nameErr = value.isEmpty
          ? 'Enter Your First Name'
          : (RegExp(r'^[a-zA-Z]+$').hasMatch(value)
          ? null
          : 'Invalid characters. Please use only letters and spaces.') ??
          (value.length < 2 ? 'Invalid Length' : null);
    });
  }

  void _validateLastName(String value) {
    setState(() {
      // Validation logic for the last name
      _lnameErr = value.isEmpty
          ? 'Enter Your Last Name'
          : (RegExp(r'^[a-zA-Z]+$').hasMatch(value)
          ? null
          : 'Invalid characters. Please use only letters and spaces.') ??
          (value.length < 2 ? 'Invalid Length' : null);
    });
  }

  void _validateEmail(String value) {
    setState(() {
      // Validation logic for email
      _emailErr = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(value)
          ? null
          : 'Enter a valid email address';
    });
  }


  void _validatePassword(String value) {
    setState(() {
      // Validation logic for password
      _passwordController.value = _passwordController.value.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
      _passwordErr = _validatePasswordRules(value);
    });
  }


  void _validateConfirmPassword(String value) {
    setState(() {
      // Validation logic for confirm password
      _confirmPasswordController.value =
          _confirmPasswordController.value.copyWith(
            text: value,
            selection: TextSelection.collapsed(offset: value.length),
          );
      _confirmPasswordErr = _validateConfirmPasswordRules(value);
    });
  }


  String? _validatePasswordRules(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    } else {
      return null; // Password is valid
    }
  }

  String? _validateConfirmPasswordRules(String value) {
    if (value.isEmpty) {
      return 'Confirm Password cannot be empty';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    } else {
      return null; // Confirm Password is valid
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    });
  }

  void _validatePhoneNumber(PhoneNumber phoneNumber) {
    setState(() {
      if (phoneNumber.phoneNumber == null || phoneNumber.phoneNumber!.isEmpty) {
        _phoneNumberErr = 'Phone number cannot be empty';
      } else if (phoneNumber.phoneNumber!.length != 13) {
        _phoneNumberErr = phoneNumber.phoneNumber!.length < 13
            ? 'Invalid Phone number...too short'
            : 'Phone number cannot exceed 10 digits';
      } else {
        _phoneNumberErr = null; // Clear error message for valid number
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {}); // Rebuild _buildPhoneNumberField to reflect error update
    });
  }

  void _validateAndNavigate() {
    // Check for empty fields first
    if (_nameController.text.isEmpty ||
        _lnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      // At least one field is empty, show a message or handle it accordingly
      print('Please fill in all fields.');
      return;
    }

    // Validate all fields before navigating to the login page
    if (_nameErr == null &&
        _lnameErr == null &&
        _emailErr == null &&
        _phoneNumberErr == null &&
        _passwordErr == null &&
        _confirmPasswordErr == null) {
      // All fields are error-free, navigate to the login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const loginscreen()),
      );
    } else {
      // Display a dialog or message to inform the user about validation errors
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Validation Error'),
            content: Text('Please fix the highlighted errors and try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}