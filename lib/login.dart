import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healthify/config/authnication.dart';
import 'package:healthify/home.dart';
import 'package:healthify/navigation_menu.dart';
import 'package:healthify/signup.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  String? _emailErr;
  String? _passwordErr;

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  final authnicationfirebase authfirebase = new authnicationfirebase();


  //////// Google ////////
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: screenSize.height,
            width: screenSize.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(220, 174, 255, 255),
                Color.fromARGB(220, 137, 238, 255),
                Color.fromARGB(220, 176, 226, 255),
                Color.fromARGB(220, 59, 206, 255),
              ]),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Center the content vertically
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.12),
                      child: Row(
                        children: [
                          Transform(
                            transform:
                                Matrix4.translationValues(28.0, -21.0, 0.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Opacity(
                                    opacity: 0.6,
                                    child: Transform(
                                      transform: Matrix4.translationValues(
                                          -4.5, -28.8, 0.0),
                                      child: Lottie.asset(
                                        'assets/Video/anime.json',
                                        fit: BoxFit.cover,
                                        height: screenSize.height * 0.135,
                                        width: screenSize.height * 0.135,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 9.0),
                                Text(
                                  "Welcome Back !!,\nSign In",
                                  style: TextStyle(
                                    fontSize: 27 * textScaleFactor,
                                    color: Color.fromARGB(255, 72, 72, 72),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      // Wrap with Center widget to move the container to the center
                      child: Container(
                        width: screenSize.width,
                        // Adjust the width of the container as needed
                        height: screenSize.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(36)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.2 * textScaleFactor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTextInput(
                                controller: emailcontroller,
                                onChanged: _validateEmail,
                                hintText: "Email",
                                errorText: _emailErr,
                                icon: Icons.mail,
                              ),
                              SizedBox(height: 20),
                              _buildPasswordField(
                                controller: passwordcontroller,
                                onChanged: _validatePassword,
                                hintText: "Password",
                                errorText: _passwordErr,
                                icon: Icons.lock_open,
                                isHidden: _isPasswordHidden,
                                onPressed: _togglePasswordVisibility,
                              ),
                              // TextField(
                              //   decoration: InputDecoration(
                              //     contentPadding: EdgeInsets.symmetric(vertical: 9.0 * textScaleFactor),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                              //       borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                              //       borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                              //     ),
                              //     prefixIcon: Icon(Icons.person_2_rounded, color: Color.fromARGB(220, 59, 206, 255),
                              //         size: 21.6* textScaleFactor),
                              //     hintText: "Gmail",
                              //   ),
                              //   controller: emailcontroller,
                              // ),
                              // SizedBox(height: 18 * textScaleFactor),
                              // TextField(
                              //    controller: passwordcontroller,
                              //   decoration: InputDecoration(
                              //     contentPadding: EdgeInsets.symmetric(vertical: 9.0 * textScaleFactor),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                              //       borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(color: Color.fromARGB(220, 59, 206, 255)),
                              //       borderRadius: BorderRadius.all(Radius.circular(18 * textScaleFactor)),
                              //     ),
                              //     prefixIcon: Icon(Icons.lock_open, color: Color.fromARGB(220, 59, 206, 255), size: 21.6 * textScaleFactor),
                              //     hintText: "Password",
                              //   ),
                              // ),
                              SizedBox(height: 27 * textScaleFactor),
                              Container(
                                width: double.infinity,
                                height: 36 * textScaleFactor,
                                child: ElevatedButton(
                                  onPressed: () {
                                    [
                                      if (_validateAndNavigate())
                                        {
                                          authfirebase
                                              .loginwithemailandpassword(
                                                  emailcontroller.text.trim(),
                                                  passwordcontroller.text
                                                      .trim())
                                              .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const NavigationMenu()));
                                          }),
                                        }
                                      else
                                        {
                                          AlertDialog(
                                              title: Text('Validation Error'),
                                              content: Text(
                                                  'Please fix the highlighted errors and try again.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('OK'),
                                                )
                                              ])
                                        }
                                    ];
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black87,
                                    backgroundColor:
                                        Color.fromARGB(255, 111, 210, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          33.3 * textScaleFactor),
                                    ),
                                  ),
                                  child: Text("Continue",
                                      style: TextStyle(
                                        fontSize: 16.2 * textScaleFactor,
                                      )),
                                ),
                              ),
                              SizedBox(height: 22.5 * textScaleFactor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      endIndent: 4.5 * textScaleFactor,
                                    ),
                                  ),
                                  Text(
                                    "Or Continue with",
                                    style: TextStyle(
                                      fontSize: 16.2 * textScaleFactor,
                                      color: Color.fromARGB(255, 72, 72, 72),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      indent: 4.5 * textScaleFactor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: 27 * textScaleFactor,
                                      height: 27 * textScaleFactor,
                                      child:
                                          Image.asset("assets/images/goog.png"),
                                    ),
                                    onTap: signinwithgoogle,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(7.2 * textScaleFactor),
                                    child: Container(
                                      width: 27 * textScaleFactor,
                                      height: 27 * textScaleFactor,
                                      child: Image.asset(
                                          "assets/images/instagram.png"),
                                    ),
                                  ),
                                  Container(
                                    width: 27 * textScaleFactor,
                                    height: 27 * textScaleFactor,
                                    child:
                                        Image.asset('assets/images/phone.png'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9 * textScaleFactor),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 9 * textScaleFactor),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.5 * textScaleFactor,
                          vertical: 9 * textScaleFactor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 13.5 * textScaleFactor,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5 * textScaleFactor,
                                color: Colors.red,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
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
      passwordcontroller.value = passwordcontroller.value.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
      _passwordErr = _validatePasswordRules(value);
    });
  }

  String? _validatePasswordRules(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else {
      return null; // Password is valid
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  bool _validateAndNavigate() {
    _validateEmail(emailcontroller.text);
    _validatePassword(passwordcontroller.text);

    if (_emailErr == null && _passwordErr == null) {
      return true;
    } else {
      return false;
    }
  }

  // signinwithgoogle() async{
  //
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //   final GoogleSignInAccount? googleSignInAccount =
  //   await googleSignIn.signIn();
  //
  //   if (googleSignInAccount != null) {
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //   accessToken: googleSignInAuthentication.accessToken,
  //   idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   try {
  //   final UserCredential userCredential =
  //   await auth.signInWithCredential(credential);
  //
  //   user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //   if (e.code == 'account-exists-with-different-credential') {
  //   // handle the error here
  //   }
  //   else if (e.code == 'invalid-credential') {
  //   // handle the error here
  //   }
  //   } catch (e) {
  //   // handle the error here
  //   }
  //   }
  //
  //   return user;
  //   }

  signinwithgoogle() async{

    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

        if(googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          await auth.signInWithCredential(credential);
          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        print("error");
      }
    }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

}

