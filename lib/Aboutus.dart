import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Container(
                height:700,
                width: double.infinity,
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: Image.asset("assets/images/Healthify_founder.jpeg",fit: BoxFit.fitHeight)
                  ),
                ),
              ),
              Text("Healthify is services application which will provide service such as :\n"
                  "1. Appointment BOOKING Service. \n"
                  "2. Hospital  &  Doctor Details. \n"
                  "3. Daily news update."
               ,

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
      ),
    );
  }
}