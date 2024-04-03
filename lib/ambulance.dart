import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';



class AmbulanceScreen extends StatefulWidget {
  @override
  _AmbulanceScreenState createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {
  GoogleMapController? mapController;
  Location location = Location();
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, you can now access the location
    } else if (status.isDenied) {
      // Permission denied, handle it accordingly
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
    }
  }




  void _getUserLocation() async {
    try {
      var userLocation = await location.getLocation();
      if (mounted) {
        setState(() {
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(userLocation.latitude ?? 0.0, userLocation.longitude ?? 0.0),
                zoom: 14.0,
              ),
            ),
          );
          // Add a marker for user's current location
          markers.add(
            Marker(
              markerId: MarkerId("user_location"),
                position: LatLng(userLocation.latitude ?? 0.0, userLocation.longitude ?? 0.0),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(
                title: "Your Location",
              ),
            ),
          );
          // In real-world scenario, you would fetch nearby ambulances
          // and add markers for each ambulance here.
        });
      }
    } catch (e) {
      print("Error getting user location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthify'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: markers,
      ),
    );
  }
}
