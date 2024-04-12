import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'constants.dart';

class CancelRequestsForUserScreen extends StatefulWidget {


  String? gdocid=globalDocID;


  @override
  _CancelRequestsForUserScreenState createState() => _CancelRequestsForUserScreenState();
}

class _CancelRequestsForUserScreenState extends State<CancelRequestsForUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Requests for ${widget.gdocid}'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cancellation_requests')
            .where('phoneused', isEqualTo: globalMobile)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No cancel requests found for ${widget.gdocid}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var requestData = snapshot.data!.docs[index].data();
                // Assuming your cancel request data has fields like 'reason', 'user_id', etc.
                // return ListTile(
                //   title: Text(requestData?['reason']),
                //   subtitle: Text('User ID: ${requestData['user_id']}'),
                //   // Add more fields as needed
                // );
              },
            );
          }
        },
      ),
    );
  }
}
