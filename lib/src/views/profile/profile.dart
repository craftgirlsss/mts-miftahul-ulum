import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_univ/src/components/alert.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';

import '../login/login.dart';
import 'change_password.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AccountsController accountsController = Get.find();
  LocationController locationController = Get.find();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Info Saya",
                style: kDefaultTextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/default-person.png'),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Obx(
                        () => Text(
                          accountsController.guruModels.value?.data.guruNama ??
                              "Tidak diketahui",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: kDefaultTextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CupertinoFormSection.insetGrouped(
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      margin: const EdgeInsets.all(0),
                      children: [
                        CupertinoListTile.notched(
                          backgroundColor: Colors.black87,
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: CupertinoColors.systemPurple,
                            ),
                            child: const Icon(
                              CupertinoIcons.mail_solid,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          additionalInfo: Obx(
                            () => Text(
                              accountsController
                                  .guruModels.value!.data.guruEmail!,
                              style: kDefaultTextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                          ),
                          title: Text(
                            'Email',
                            style: kDefaultTextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          // trailing: const CupertinoListTileChevron(),
                          // onTap: () {},
                        ),
                        CupertinoListTile.notched(
                          backgroundColor: Colors.black87,
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: CupertinoColors.activeGreen,
                            ),
                            child: const Icon(
                              CupertinoIcons.book,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          additionalInfo: Obx(
                            () => Text(
                              accountsController
                                      .guruModels.value?.data.guruNip ??
                                  '-',
                              style: kDefaultTextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                          ),
                          title: Text(
                            'NIP',
                            style: kDefaultTextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          // trailing: const CupertinoListTileChevron(),
                          // onTap: () {},
                        ),
                        CupertinoListTile.notched(
                          backgroundColor: Colors.black87,
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: CupertinoColors.activeBlue,
                            ),
                            child: const Icon(
                              CupertinoIcons.number,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          additionalInfo: Obx(
                            () => Text(
                              "${accountsController.guruModels.value?.data.guruId ?? 0}",
                              style: kDefaultTextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                          ),
                          title: Text(
                            'ID Pengajar',
                            style: kDefaultTextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          // trailing: const CupertinoListTileChevron(),
                          // onTap: () {},
                        ),
                        CupertinoListTile.notched(
                          backgroundColor: Colors.black87,
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: CupertinoColors.systemIndigo,
                            ),
                            child: const Icon(
                              CupertinoIcons.location,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          additionalInfo: Obx(
                            () => Flexible(
                              child: Text(
                                locationController.currentAddress.value,
                                overflow: TextOverflow.ellipsis,
                                style: kDefaultTextStyle(
                                    color: Colors.white38, fontSize: 12),
                              ),
                            ),
                          ),
                          title: Text(
                            'Tempat Clockin',
                            style: kDefaultTextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          // trailing: const CupertinoListTileChevron(),
                          // onTap: () {},
                        ),
                        CupertinoListTile.notched(
                          backgroundColor: Colors.black87,
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: CupertinoColors.activeOrange,
                            ),
                            child: const Icon(
                              CupertinoIcons.padlock_solid,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: Text(
                            'Ganti Password',
                            style: kDefaultTextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                            Get.to(() => const GantiPassword());
                          },
                        ),
                        CupertinoListTile.notched(
                          backgroundColor: Colors.black87,
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: CupertinoColors.systemRed,
                            ),
                            child: const Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: Text(
                            'Log Out',
                            style: kDefaultTextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                            showAlertDialog(context, onOk: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove('login');
                              prefs.remove('nip');
                              Get.back();
                              setState(() {
                                isLoading = true;
                              });
                              Future.delayed(const Duration(seconds: 4), () {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ViewLogin()),
                                    (route) => false);
                              });
                            },
                                title: "Keluar",
                                description:
                                    "Apakah anda yakin log out dari akun ini?");
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading == true ? floatingLoading() : const SizedBox(),
      ],
    );
  }
}
