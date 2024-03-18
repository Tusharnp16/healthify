import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {

  final String? id;
  final String? mobile;
  final String? firstname;
  final String? lastname;
  final String? email;

  const Usermodel({
    this.id,
    required this.mobile,
    required this.firstname,
    required this.lastname,
    required this.email
  });

  toJson() {
    return {
      "First Name": firstname,
      "Last name": lastname,
      "Mobile": mobile,
      "Email": email,
    };
  }

  factory Usermodel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data()!;
    return Usermodel(
      //  id: document.id,
      mobile: data["Mobile"],
      firstname: data["First Name"],
      lastname: data["Last name"],
      email: data["Email"],
    );
  }



}