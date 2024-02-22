import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class doctor extends StatefulWidget {
  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.asset("assets/images/admin.jpg"),
                    ),
                    title: Text("${snapshot.data!.docs[index]["Name"]}"),
                    subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    Text("${snapshot.data!.docs[index]["Mobile"]}"),
                      Text("${snapshot.data!.docs[index]["Gender"]}"),
                      Text("${snapshot.data!.docs[index]["Email"]}"),
                      Text("${snapshot.data!.docs[index]["Specialist"]}"),
                      Text("${snapshot.data!.docs[index]["Hospital"]}"),
                    ]
                    )
                  );
                });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.hasError.toString()}"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            };
            throw Exception('This widget cannot return null.');
          }),
    );
  }
}
