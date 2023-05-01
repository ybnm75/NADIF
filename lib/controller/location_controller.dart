import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Position? currentPosition;
  var isLoading = false.obs;
  String? currentLocation;

  Future<Position> getPosition() async {
    LocationPermission? permission;

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error("Permission Location are denied");
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

  }

  Future<void> getAddressFromLatLng(long,lat) async{
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);

      Placemark place = placemark[0];

      currentLocation =
      "${place.locality} , ${place.street}, ${place.subLocality} , ${place.subAdministrativeArea}";
      update();

    }catch(e) {
      print(e);
    }
  }

  //  Card(
  //   child: Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Text(
  //       "${location.isNotEmpty ? location.first.country ?? "" : ""},${location.isNotEmpty ? location.first.locality ?? "" : ""},${location.isNotEmpty ? location.first.thoroughfare ?? location.first.name ?? "" : ""}",
  //       style: const TextStyle(fontWeight: FontWeight.bold),
  //     ),
  //   ),
  // ),

  Future<void> getCurrentLocation() async {
    try {
      isLoading == true;
      update();
      currentPosition = await getPosition();
      getAddressFromLatLng(currentPosition!.longitude,currentPosition!.latitude);
      isLoading == false;
      update();
    } catch (e) {
      print(e);
    }
  }
  void dispose() {
    super.dispose();
    // clean up resources here
  }
}
