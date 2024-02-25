import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';

import 'temporary_data_view_for_guru.dart';

class ConfirmationPageGuru extends StatefulWidget {
  const ConfirmationPageGuru({super.key});

  @override
  State<ConfirmationPageGuru> createState() => _ConfirmationPageGuruState();
}

class _ConfirmationPageGuruState extends State<ConfirmationPageGuru> {
  AccountsController accountsController = Get.find();
  LocationController locationController = Get.find();
  @override
  void initState() {
    // accountsController.isLoading.value = false;
    super.initState();
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
  void showAlertDialog(context, {Function()? onOK}) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah anda yakin mengakhiri sesi absensi?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Belum'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: false,
            onPressed: onOK,
            child: const Text('Akhiri'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                () => accountsController.isLoading.value == true
                    ? Container()
                    : TextButton(
                        onPressed: accountsController
                                .daftarAbsenceTempGuru.isEmpty
                            ? () {
                                Get.snackbar("Informasi",
                                    "Belum ada data ditambahkan, mohon klik lanjutkan scan untuk menambah data",
                                    colorText: Colors.black,
                                    backgroundColor: Colors.white);
                              }
                            : () {
                                Get.to(() => const TemporaryDataViewForGuru());
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
                          () => accountsController.guruModelsForAbsence.value !=
                                  null
                              ? Text(
                                  accountsController.guruModelsForAbsence.value
                                          ?.data.guruNama ??
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
                          () => accountsController.guruModelsForAbsence.value !=
                                  null
                              ? Text(
                                  accountsController.guruModelsForAbsence.value
                                          ?.data.guruGender ??
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
                          () => accountsController.guruModelsForAbsence.value !=
                                  null
                              ? Text(
                                  accountsController.guruModelsForAbsence.value
                                          ?.data.guruTempat ??
                                      '-',
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'Penempatan',
                          style: kDefaultTextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
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
                          () => accountsController.guruModelsForAbsence.value !=
                                  null
                              ? Text(
                                  "${accountsController.guruModelsForAbsence.value?.data.guruNip ?? 0}",
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'NIP',
                          style: kDefaultTextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
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
                          () => accountsController.guruModelsForAbsence.value !=
                                  null
                              ? Text(
                                  "${accountsController.guruModelsForAbsence.value?.data.guruId ?? 0}",
                                  style: kDefaultTextStyle(
                                      color: Colors.white38, fontSize: 12),
                                )
                              : const Text('-'),
                        ),
                        title: Text(
                          'ID Guru',
                          style: kDefaultTextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
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
                      onPressed: accountsController.isLoading.value == true
                          ? () {
                              debugPrint("Masih Loading");
                            }
                          : () {
                              showAlertDialog(context, onOK: () async {
                                Navigator.pop(context);
                                if (await accountsController
                                        .finishAbsensiGuru() ==
                                    true) {
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    accountsController.daftarAbsenceTempGuru
                                        .clear();
                                    Navigator.pop(context);
                                  });
                                } else {
                                  Future.delayed(Duration.zero, () {
                                    Navigator.pop(context);
                                  });
                                }
                              });
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
                      onPressed: accountsController.isLoading.value == true
                          ? () {}
                          : () {
                              scanQR(context);
                            },
                      child: Text(
                        accountsController.isLoading.value == true
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
        Obx(() => accountsController.isLoading.value == true
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

    debugPrint(barcodeScanRes);

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
        Get.to(() => const ConfirmationPageGuru());
      }
    } else {
      Get.snackbar("Gagal",
          "Mohon jika sedang mengabsensi guru, untuk diselesaikan terlebih dahulu, dan jika sudah klik tombol Akhiri Absensi.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
