import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var isLoading = false.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var currentAddress = ''.obs;
  Position? _currentPosition;

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      getAddressFromLatLng();
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      currentAddress.value =
          "${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";

      // setState(() {
      //   currentAddress =
      //       "${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
      // });
    } catch (e) {
      print(e);
    }
  }
}
