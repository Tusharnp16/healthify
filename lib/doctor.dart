import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Doctor extends StatefulWidget {
  const Doctor({Key? key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  Future<Uint8List?> _getImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Failed to load image with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading image: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doctorData = snapshot.data!.docs[index].data();
                  return DoctorItem(
                    doctorData: doctorData,
                    getImage: _getImage,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class DoctorItem extends StatefulWidget {
  final Map<String, dynamic> doctorData;
  final Future<Uint8List?> Function(String) getImage;

  const DoctorItem({Key? key, required this.doctorData, required this.getImage}) : super(key: key);

  @override
  State<DoctorItem> createState() => _DoctorItemState();
}

class _DoctorItemState extends State<DoctorItem> {
  bool _showFullDetails = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: MemoryImage(Uint8List.fromList(base64Decode(widget.doctorData["image_base64"] ?? ""))),
      ),
      title: Text("${widget.doctorData["Name"] ?? ""}"),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specialist: ${widget.doctorData["Specialist"] ?? ""}"),
          _showFullDetails
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mobile: ${widget.doctorData["Mobile"] ?? ""}"),
              Text("Gender: ${widget.doctorData["Gender"] ?? ""}"),
              Text("Email: ${widget.doctorData["Email"] ?? ""}"),
              Text("Hospital: ${widget.doctorData["Hospital"] ?? ""}"),
            ],
          )
              : GestureDetector(
            onTap: () {
              setState(() {
                _showFullDetails = true;
              });
            },
            child: Text(
              'View more detail',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
