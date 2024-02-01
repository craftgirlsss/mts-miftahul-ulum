import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkPermission(Permission permission, context) async {
  final status = await permission.request();
  if (status.isGranted) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Permission is granted')));
  } else if (status.isDenied) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Permission is denied')));
  } else if (status.isPermanentlyDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission is permanently denied')));
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Permission is unknown')));
  }
}

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Get.snackbar("Information",
        'Location services are disabled. Please enable the services',
        colorText: Colors.white, backgroundColor: Colors.red);
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.snackbar("Information", 'Location permissions are denied',
          colorText: Colors.white, backgroundColor: Colors.red);
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    Get.snackbar("Information",
        'Location permissions are permanently denied, we cannot request permissions.',
        colorText: Colors.white, backgroundColor: Colors.red);
    return false;
  }
  return true;
}
