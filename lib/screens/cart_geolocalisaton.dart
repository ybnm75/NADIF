import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/location_controller.dart';

class MyCard extends StatefulWidget {
  MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  LatLng point = LatLng(0, 0);
  var location = [];

  CollectionReference _referenceUserList = FirebaseFirestore.instance.collection('Userss');
  late Stream<QuerySnapshot> _streamUserData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamUserData = _referenceUserList.snapshots();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          LatLng myLatLng = LatLng(36.9, 7.6609);
          return Stack(
            children: [
              FlutterMap(
                  options: MapOptions(
                      onTap: (TapPosition tapPosition, LatLng latLng) async {
                        location = await placemarkFromCoordinates(
                            latLng.latitude, latLng.longitude);
                        print(
                            "${location.isNotEmpty ? location.first.country ?? "" : ""}");
                        setState(() {
                          point = latLng;
                        });
                      },
                      center: myLatLng,
                      zoom: 10.0),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            width: 100.0,
                            height: 100.0,
                            point: point,
                            builder: (ctx) => const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 30.0,
                            ))
                      ],
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 34.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Card(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on_outlined),
                          hintText: "Search for location",
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                    Card(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : Column(
                        children: [
                          Padding(
                            padding:
                           const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              controller.currentLocation == null
                                  ? 'No location found'
                                  : controller.currentLocation!,
                              style: const TextStyle(fontSize: 20.0,backgroundColor: Colors.transparent,color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          ElevatedButton(onPressed: (){
                            controller.getCurrentLocation();
                          }, child: const Text('Get Current Location'),),

                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,

                            side: const BorderSide(
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.blueGrey),
                        onPressed: (){
                        },
                        child: const Text('Trouver un Fournisseur:'), ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
