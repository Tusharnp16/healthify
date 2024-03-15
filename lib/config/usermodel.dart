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
}