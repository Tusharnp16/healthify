import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:healthify/config/authnication.dart';
import 'package:healthify/config/usermodel.dart';
import 'package:healthify/config/userreposetory.dart';
import 'package:healthify/home.dart';
import 'package:healthify/navigation_menu.dart';
import 'login.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  String? _nameErr;
  String? _lnameErr;
  String? _emailErr;
  String? _passwordErr;
  String? _confirmPasswordErr;
  String? _phoneNumberErr;
  String? _selectedGender;
  String? _dateOfBirthErr;
  String? _gendererr;

  authnicationfirebase authfirebase = new authnicationfirebase();
  late Usermodel newuser;
  final UserRepository userRepo = new UserRepository();
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
                      _buildGenderField(),
                      SizedBox(height: 20),
                      _buildDateOfBirthField(),
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
                          backgroundColor: Color.fromARGB(220, 115, 208, 239),
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

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person_outline, color: Colors.blue),
            SizedBox(height: 8, width: 20),
            Text(
              'Gender',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8, width: 20),
            Radio(
              value: 'male',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value.toString();
                  _genderController.text = value.toString();
                });
              },
            ),
            Text('Male'),
            SizedBox(width: 20),
            Radio(
              value: 'female',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value.toString();
                  _genderController.text = value.toString();
                });
              },
            ),
            Text('Female'),
          ],
        ),
        if (_gendererr != null)
          Text(
            _gendererr!,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
      ],
    );
  }



  Widget _buildDateOfBirthField() {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          setState(() {
            _dateOfBirthController.text = formattedDate;
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: _dateOfBirthController,
          decoration: InputDecoration(
            labelText: 'Date of Birth (DD/MM/YYYY)',
            prefixIcon: Icon(Icons.calendar_today),
            hintText: 'DD/MM/YYYY',
            errorText: _dateOfBirthErr,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          keyboardType: TextInputType.datetime,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your date of birth';
            }
            // Validate the format of the date
            if (!_isDateValid(value)) {
              return 'Please enter a valid date in DD/MM/YYYY format';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _dateOfBirthErr = null;
            });
          },
        ),
      ),
    );
  }


  bool _isDateValid(String value) {
    final datePattern =
        r'^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)(\d{4})$';
    return RegExp(datePattern).hasMatch(value);
  }

  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        IntlPhoneField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
          ),
          initialCountryCode: 'IN',
          onChanged: (phone) {
            // Handle phone number change
          },
          onCountryChanged: (phone) {
            // Handle country code change
          },
          controller: _phoneNumberController,
          validator: (value) {
            if (value == null) {
              return 'Phone number cannot be empty';
            }
            return null;
          },
        ),
        if (_phoneNumberErr != null)
          Text(
            _phoneNumberErr!,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
      ],
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
        prefixIcon: Icon(icon, color: Color.fromARGB(220, 59, 206, 255)),
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
        prefixIcon: Icon(icon, color: Color.fromARGB(220, 59, 206, 255)),
        suffixIcon: IconButton(
          icon: Icon(
            isHidden ? Icons.visibility : Icons.visibility_off,
            color: Color.fromARGB(220, 59, 206, 255),
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
      borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
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

  void _validatePhoneNumber(String phoneNumber) {
    setState(() {
      if (phoneNumber.isEmpty) {
        _phoneNumberErr = 'Phone number cannot be empty';
      } else if (phoneNumber.length != 13) {
        _phoneNumberErr = phoneNumber.length < 13
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

  void _validateAndNavigate() async {
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
        _confirmPasswordErr == null &&
        _selectedGender != null &&
        _dateOfBirthErr == null) {
      // All fields are error-free, continue with Firebase authentication
      try {
        final Usermodel newUser = Usermodel(
          mobile: _phoneNumberController.text.trim(),
          firstname: _nameController.text.trim(),
          lastname: _lnameController.text.trim(),
          email: _emailController.text.trim(),
          // dob: DateTime.parse(_dateOfBirthController.text),
          gender: _selectedGender!,
        );
        await authfirebase.registewithemailandpassword(
            _emailController.text.trim(),
            _confirmPasswordController.text.trim());
        await userRepo.saveuserrecord(newUser);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NavigationMenu()));
      } catch (e) {
        print('Error occurred: $e');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred. Please try again later.'),
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
