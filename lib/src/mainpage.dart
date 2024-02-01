import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';

import 'views/home/absensi.dart';
import 'views/profile/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LocationController locationController = Get.put(LocationController());
  AccountsController accountsController = Get.put(AccountsController());

  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    accountsController.getDataPengajar();
    super.initState();
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
              label: 'Absensi',
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
        const AbsensiPage(),
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
            // Get.to(() => const QRCodePage());
            // _getCurrentLocation();
            // if (_currentAddress != null) debugPrint(_currentAddress);
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
}
