import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Healthify is services application which will provide service such as :\n"
                "1. Appointment BOOKING Service. \n"
                "2. Hospital  &  Doctor Details. \n"
                "3. Daily news update."
              "4. Git hub connecetion successful",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.lightBlue,
              ),),
            Text(" FOUNDER OF HEALTHIFY : TUSHAR ,KAMLESH & HEMANT ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.lightBlue,
              ),)
          ],
        ),
      ),
    );
  }
}