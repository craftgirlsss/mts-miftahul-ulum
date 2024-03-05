import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';
import 'package:socio_univ/src/views/home/daftar_kelas.dart';
import 'package:socio_univ/src/views/qrpage/confirmation_page_guru.dart';

import 'views/profile/profile.dart';
import 'views/qrpage/confirmation_absence.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LocationController locationController = Get.put(LocationController());
  AccountsController accountsController = Get.put(AccountsController());
  SiswaController siswaController = Get.put(SiswaController());

  Position? positionNow;
  String? _address;
  String jarak = "";
  double latkantor = -7.3783061, longkantor = 112.6857011;
  late double lat;
  late double long;
  String? myLongitude;
  String? myLatitude;
  final Set<Marker> _marker = {};

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    String address = await _getAddressFormLatLongOnline(position);
    setState(() {
      positionNow = position;
      lat = position.latitude;
      long = position.longitude;
      _address = address;
    });
  }

  void marker() async {
    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      _marker.add(
        Marker(
          markerId: const MarkerId("Lokasi saat ini"),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: InfoWindow(
            title: "Posisi Anda Sekarang",
            snippet: _address,
          ),
        ),
      );
    });
    setState(() {
      myLongitude = pos.longitude.toString();
      myLatitude = pos.latitude.toString();
      locationController.latitude.value = myLatitude!;
      locationController.longitude.value = myLongitude!;
      jarak = Geolocator.distanceBetween(
              latkantor, longkantor, pos.latitude, pos.longitude)
          .floor()
          .toString();
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getAddressFormLatLongOnline(Position param) async {
    try {
      List<Placemark> placemarkList = await placemarkFromCoordinates(
        param.latitude,
        param.longitude,
        localeIdentifier: "id",
      );
      Placemark place = placemarkList[0];
      locationController.currentAddress.value =
          "${place.administrativeArea} ${place.subAdministrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare} ${place.subThoroughfare} ${place.name}";
      return _address =
          "${place.country} ${place.postalCode} ${place.administrativeArea} ${place.subAdministrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare} ${place.subThoroughfare} ${place.name}";
    } catch (e) {
      return "Log error$e";
    }
  }

  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    accountsController.getDataPengajar(context);
    super.initState();
    _getCurrentLocation();
    marker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.white54,
          ),
        )),
        child: NavigationBar(
          labelBehavior: labelBehavior,
          backgroundColor: Colors.black12,
          selectedIndex: currentPageIndex,
          indicatorColor: Colors.white38,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(CupertinoIcons.person_2_square_stack_fill),
              icon: Icon(
                CupertinoIcons.person_2_square_stack,
                color: Colors.white54,
              ),
              label: 'Kelas',
            ),
            NavigationDestination(
              selectedIcon: Icon(CupertinoIcons.person_alt_circle_fill),
              icon: Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.white54,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: <Widget>[
        const DaftarKelas(),
        const ProfilePage(),
      ][currentPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        shape: const CircleBorder(),
        color: Colors
            .green.shade400, // container color,to have splash color effect
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: Colors.white10.withOpacity(0.1),
          onTap: () {
            scanQR(context);
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              //         shape: BoxShape.circle,
              shape: BoxShape.circle,
              color: Colors.transparent, // material color will cover this
            ),
            child: const Icon(
              CupertinoIcons.qrcode,
              size: 35,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scanQR(context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    if (barcodeScanRes[0] == 'e') {
      String resultBarcode = barcodeScanRes.substring(1);
      if (await accountsController.getDataPengajarForAbsence(context,
              nip: resultBarcode) ==
          true) {
        accountsController.daftarAbsenceTempGuru.add({
          'guru_id': accountsController.guruModelsForAbsence.value?.data.guruId,
          'guru_nama':
              accountsController.guruModelsForAbsence.value?.data.guruNama ??
                  'Tidak ada nama',
          'guru_nip':
              accountsController.guruModelsForAbsence.value?.data.guruNip ??
                  '0',
          'gender':
              accountsController.guruModelsForAbsence.value?.data.guruGender ??
                  'Gender belum diset',
          'keterangan': 1,
          'logitude': locationController.longitude.value,
          'latitude': locationController.latitude.value,
          'location': locationController.currentAddress.value
        });
        // print("Ini data sudah masuk");
        // print(
        //     "ini isLoading Accounts Controller ${accountsController.isLoading.value}");
        Get.to(() => const ConfirmationPageGuru());
      } else {
        Get.snackbar("Gagal", "Data guru tidak ditemukan, mohon konfirmasikan ke pihak admin karena NIP bersangkutan tidak ada dalam database", backgroundColor: Colors.red, colorText: Colors.white);
        Get.back();
      }
    } else {
      if (await siswaController.getDataSiswa(nis: barcodeScanRes) == true) {
        siswaController.isLoading.value == true;
        siswaController.personsV2.add({
          'siswa_nama': siswaController.siswaModels.value?.data.siswaNama,
          'siswa_nis': siswaController.siswaModels.value?.data.siswaNis ?? '0',
          'guru_id': accountsController.guruModels.value?.data.guruId ?? '0',
          'keterangan': 1,
          'gender': siswaController.siswaModels.value?.data.siswaGender ?? '-',
          'longitude': locationController.longitude.value,
          'latitude': locationController.latitude.value,
          'location': locationController.currentAddress.value
        });
        siswaController.isLoading.value == false;
        Get.to(() => const ConfirmationPage());
      }else{
        Get.snackbar("Gagal", "Data siswa tidak ditemukan, mohon konfirmasikan ke pihak guru karena NIS tidak ada dalam database", backgroundColor: Colors.red, colorText: Colors.white);
        Get.back();
      }
    }
  }
  /* 
  [
     {
        "siswa_nis": 190255, 
        "guru_id": 3035453000003, 
        "keterangan": 1,
        "longitude": "-12987e3129321",
        "latitude": "-817263846912" ,
        "location": "Madura",
        "siswa_nama": "awdawdawd",
        "gender": "P"
    }
]
  */
}
