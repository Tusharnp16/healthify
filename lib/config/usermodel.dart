import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {

  final String? id;
  final String? mobile;
  final String? firstname;
  final String? lastname;
  final String? email;
  // final DateTime dob;
  final String? gender;
  const Usermodel({
    this.id,
    required this.mobile,
    required this.firstname,
    required this.lastname,
    required this.email,
    // required this.dob,
    required this.gender
  });

  toJson() {
    return {
      "First Name": firstname,
      "Last name": lastname,
      "Mobile": mobile,
      "Email": email,
      "Gender": gender,
      // "DOB": dob,

    };
  }

  factory Usermodel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data()!;
    return Usermodel(
        id: document.id,
      mobile: data["Mobile"],
      firstname: data["First Name"],
      lastname: data["Last name"],
      email: data["Email"],
      gender: data["Gender"],
      // dob: data["DOB"]


    );
  }



}