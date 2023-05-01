import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    // Get current location when the map screen is loaded
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14.0,
        ),
        markers: Set<Marker>.of(
          <Marker>[
            Marker(
              markerId: MarkerId('currentLocation'),
              position: currentLocation,
              infoWindow: InfoWindow(
                title: 'Current Location',
                snippet: 'Your current location.',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
          // Move camera to current location when the button is pressed
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLocation,
              zoom: 14.0,
            ),
          ));
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}


