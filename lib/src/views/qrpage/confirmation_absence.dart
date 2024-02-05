import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';

import 'temporary_data_view.dart';

class ConfirmationPage extends StatefulWidget {
  final String nis;
  const ConfirmationPage({super.key, required this.nis});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  SiswaController siswaController = Get.find();
  AccountsController accountsController = Get.find();
  LocationController locationController = Get.find();

  @override
  void initState() {
    super.initState();
    siswaController.getDataSiswa(nis: widget.nis);
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
  void showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah anda yakin mengakhiri sesi absensi?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // PopScope(
        //   canPop: false,
        //   onPopInvoked: (didPop) => _showAlertDialog(context),
        //   child:
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Konfirmasi Absensi",
              style: kDefaultTextStyle(color: Colors.white, fontSize: 17),
            ),
            automaticallyImplyLeading: false,
            actions: [
              Obx(
                () => siswaController.isLoading.value == true
                    ? Container()
                    : TextButton(
                        onPressed: siswaController.personsV2.isEmpty
                            ? () {
                                Get.snackbar("Informasi",
                                    "Belum ada data ditambahkan, mohon klik lanjutkan scan untuk menambah data",
                                    colorText: Colors.black,
                                    backgroundColor: Colors.white);
                              }
                            : () {
                                Get.to(() => const TemporaryDataView());
                              },
                        child: const Text("Lihat Data")),
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/default-person.png'),
                            fit: BoxFit.cover)),
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
                            CupertinoIcons.person_fill,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        additionalInfo: Obx(
                          () => siswaController.siswaModels.value != null
                              ? Text(
                                  siswaController
                                          .siswaModels.value?.data.siswaNama ??
                                      '-',
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'Name',
                          style: kDefaultTextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        // trailing: const CupertinoListTileChevron(),
                        onTap: () {
                          // Get.defaultDialog(
                          //     title: "Print",
                          //     content:
                          //         Text(jsonEncode(siswaController.personsV2)));
                        },
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
                            CupertinoIcons.person_crop_rectangle,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        additionalInfo: Obx(
                          () => siswaController.siswaModels.value != null
                              ? Text(
                                  siswaController.siswaModels.value?.data
                                          .siswaGender ??
                                      '-',
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'Jenis Kelamin',
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
                          () => siswaController.siswaModels.value != null
                              ? Text(
                                  siswaController.siswaModels.value?.data
                                          .siswaKelasterima ??
                                      '-',
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'Kelas',
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
                            CupertinoIcons.arrow_down_doc_fill,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        additionalInfo: Obx(
                          () => siswaController.siswaModels.value != null
                              ? Text(
                                  "${siswaController.siswaModels.value?.data.siswaNis ?? 0}",
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'NIS',
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
                          () => siswaController.siswaModels.value != null
                              ? Text(
                                  "${siswaController.siswaModels.value?.data.siswaId ?? 0}",
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'ID Siswa',
                          style: kDefaultTextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        // trailing: const CupertinoListTileChevron(),
                        // onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Obx(
                  () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeBlue),
                      onPressed: siswaController.isLoading.value == true
                          ? () {}
                          : () async {
                              if (await siswaController.finishAbsensi() ==
                                  true) {
                                Future.delayed(const Duration(seconds: 2), () {
                                  siswaController.personsV2.clear();
                                  Navigator.pop(context);
                                });
                                // Get.defaultDialog(
                                //     backgroundColor: Colors.green.shade400,
                                //     title: "Berhasil",
                                //     content: const Text(
                                //         "Berhasil upload data absensi"),
                                //     barrierDismissible: false,
                                //     onConfirm: () {
                                //       Get.back();
                                //     });
                              }
                              // Get.off(() => const MainPage());
                            },
                      child: Text(
                        "Akhiri Absensi",
                        style: kDefaultTextStyle(
                            color: Colors.white, fontSize: 15),
                      )),
                )),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeGreen),
                      onPressed: siswaController.isLoading.value == true
                          ? () {}
                          : () {
                              scanQR(context);
                            },
                      child: Text(
                        siswaController.isLoading.value == true
                            ? "Saving..."
                            : "Lanjutkan Scan",
                        style: kDefaultTextStyle(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        Obx(() => siswaController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
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
    if (await siswaController.getDataSiswa(nis: barcodeScanRes) == true) {
      HapticFeedback.lightImpact();
      // SystemSound.play(SystemSoundType.click);
      siswaController.isLoading.value == true;
      siswaController.personsV2.add({
        'siswa_nama': siswaController.siswaModels.value?.data.siswaNama,
        'siswa_nis': siswaController.siswaModels.value?.data.siswaNis ?? 0,
        'guru_id': accountsController.guruModels.value?.data.guruId ?? 0,
        'keterangan': 1,
        'gender': siswaController.siswaModels.value?.data.siswaGender ?? '-',
        'longitude': locationController.longitude.value,
        'latitude': locationController.latitude.value,
        'location': locationController.currentAddress.value
      });
      siswaController.isLoading.value == false;
      Get.to(() => ConfirmationPage(nis: barcodeScanRes));
    }
  }
}
