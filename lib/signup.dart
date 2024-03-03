import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  TextEditingValue formatEditValue(
      TextEditingValue oldValue, TextEditingValue newValue) {
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
  final TextEditingController _confirmPasswordController =
  TextEditingController();

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back !!,\nSign In",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextInput(
                        controller: _nameController,
                        onChanged: _validateName,
                        hintText: "First Name",
                        errorText: _nameErr,
                        icon: Icons.person_3_rounded,
                      ),
                      SizedBox(height: 20),
                      _buildTextInput(
                        controller: _lnameController,
                        onChanged: _validateLastName,
                        hintText: "Last Name",
                        errorText: _lnameErr,
                        icon: Icons.person_3_rounded,
                      ),
                      SizedBox(height: 20),
                      _buildPhoneNumberField(),
                      SizedBox(height: 20),
                      _buildTextInput(
                        controller: _emailController,
                        onChanged: _validateEmail,
                        hintText: "Email",
                        errorText: _emailErr,
                        icon: Icons.mail,
                      ),
                      SizedBox(height: 20),
                      _buildPasswordField(
                        controller: _passwordController,
                        onChanged: _validatePassword,
                        hintText: "Password",
                        errorText: _passwordErr,
                        icon: Icons.lock_open,
                        isHidden: _isPasswordHidden,
                        onPressed: _togglePasswordVisibility,
                      ),
                      SizedBox(height: 20),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        onChanged: _validateConfirmPassword,
                        hintText: "Confirm Password",
                        errorText: _confirmPasswordErr,
                        icon: Icons.lock_open,
                        isHidden: _isConfirmPasswordHidden,
                        onPressed: _toggleConfirmPasswordVisibility,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _validateAndNavigate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
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
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have An Account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
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
                            builder: (context) => loginscreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return InternationalPhoneNumberInput(
      onInputChanged: _validatePhoneNumber,
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      formatInput: false,
      keyboardType: TextInputType.phone,
      inputBorder: _inputBorderStyle(),
      errorMessage: _phoneNumberErr,
      hintText: 'Phone Number',
      initialValue: PhoneNumber(isoCode: 'IN'),
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
      _emailErr = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(value)
          ? null
          : 'Enter a valid email address';
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _passwordController.value = _passwordController.value.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
      _passwordErr = _validatePasswordRules(value);
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
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
      if (phoneNumber.phoneNumber == null ||
          phoneNumber.phoneNumber!.isEmpty) {
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
    _validateName(_nameController.text);
    _validateLastName(_lnameController.text);
    _validateEmail(_emailController.text);
    _validatePassword(_passwordController.text);
    _validateConfirmPassword(_confirmPasswordController.text);

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
            content:
            Text('Please fix the highlighted errors and try again.'),
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
