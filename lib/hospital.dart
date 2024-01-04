import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class hospital extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hospital Screen In Progress stay tuned",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.lightBlue,
              ),),
            Text("tonybhai",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.lightBlue,
              ),),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.green,
                  ),
                ),
                Text("Or conttinue with",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.lightBlue,
                  ),),
                Expanded(child: Divider())
              ],
            )


          ],
        ),
      ),
    );
  }
}