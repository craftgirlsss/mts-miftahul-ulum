import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/alert.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';

class TemporaryDataView extends StatefulWidget {
  const TemporaryDataView({super.key});

  @override
  State<TemporaryDataView> createState() => _TemporaryDataViewState();
}

class _TemporaryDataViewState extends State<TemporaryDataView> {
  SiswaController siswaController = Get.find();
  LocationController locationController = Get.find();
  AccountsController accountsController = Get.find();
  TextEditingController namaController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  // void popUpAddData() {
  //   Get.defaultDialog(
  //       content: Column(
  //         children: [
  //           Text(
  //             "Tambah data secara manual untuk siswa tidak hadir, izin, atau terlambat. \nAturan keterangan (Masuk = 1, Izin = 2, Sakit = 3, Tidak Diketahui = 4)",
  //             style: kDefaultTextStyle(color: Colors.white),
  //             textAlign: TextAlign.center,
  //           ),
  //           const SizedBox(height: 10),
  //           CupertinoTextField(
  //             controller: namaController,
  //             placeholderStyle: const TextStyle(color: Colors.black38),
  //             placeholder: "Nama",
  //             suffix: const Padding(
  //               padding: EdgeInsets.only(right: 8),
  //               child: Icon(CupertinoIcons.person, color: Colors.black26),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           CupertinoTextField(
  //             controller: nisController,
  //             keyboardType: const TextInputType.numberWithOptions(),
  //             placeholderStyle: const TextStyle(color: Colors.black38),
  //             placeholder: "NIS",
  //             suffix: const Padding(
  //               padding: EdgeInsets.only(right: 8),
  //               child: Icon(CupertinoIcons.person_crop_square,
  //                   color: Colors.black26),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           CupertinoTextField(
  //             controller: keteranganController,
  //             keyboardType: const TextInputType.numberWithOptions(),
  //             placeholderStyle: const TextStyle(color: Colors.black38),
  //             placeholder: "Keterangan",
  //             suffix: const Padding(
  //               padding: EdgeInsets.only(right: 8),
  //               child: Icon(CupertinoIcons.news, color: Colors.black26),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           CupertinoTextField(
  //             controller: jenisKelaminController,
  //             placeholderStyle: const TextStyle(color: Colors.black38),
  //             placeholder: "Jenis Kelamin",
  //             suffix: const Padding(
  //               padding: EdgeInsets.only(right: 8),
  //               child:
  //                   Icon(CupertinoIcons.personalhotspot, color: Colors.black26),
  //             ),
  //           ),
  //         ],
  //       ),
  //       backgroundColor: Colors.grey.shade900,
  //       titleStyle:
  //           kDefaultTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       title: "Tambah Manual",
  //       barrierDismissible: true,
  //       buttonColor: Colors.green,
  //       textConfirm: "Tambah",
  //       contentPadding: const EdgeInsets.all(10),
  //       onConfirm: () async {
  //         siswaController.addingData({
  //           'siswa_nama': namaController.text,
  //           'siswa_nis': nisController.text,
  //           'guru_id': accountsController.guruModels.value?.data.guruId ?? '0',
  //           'keterangan': keteranganController.text,
  //           'gender': jenisKelaminController.text,
  //           'longitude': locationController.longitude.value,
  //           'latitude': locationController.latitude.value,
  //           'location': locationController.currentAddress.value
  //         });
  //         Get.back();
  //         // siswaController.personsV2.add({
  //         //   'siswa_nama': namaController.text,
  //         //   'siswa_nis': nisController.text,
  //         //   'guru_id': accountsController.guruModels.value?.data.guruId ?? '0',
  //         //   'keterangan': keteranganController.text,
  //         //   'gender': jenisKelaminController.text,
  //         //   'longitude': locationController.longitude.value,
  //         //   'latitude': locationController.latitude.value,
  //         //   'location': locationController.currentAddress.value
  //         // });
  //       });
  //   // Get.back();
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(
              "Data Absensi Sementara",
              style: kDefaultTextStyle(fontSize: 17),
            ),
            actions: [
              Obx(
                () => siswaController.isLoading.value == true
                    ? Container()
                    : IconButton(
                        tooltip: "Hapus semua data",
                        onPressed: () {
                          showAlertDialog(context,
                              description:
                                  "Apakah anda yakin menghapus semua data?",
                              onOk: () {
                            siswaController.clearingDataTemp();
                          }, title: "Hapus");
                        },
                        icon: const Icon(
                          CupertinoIcons.trash,
                          color: Colors.white60,
                        ),
                      ),
              ),
              // Obx(
              //   () => siswaController.isLoading.value == true
              //       ? Container()
              //       : IconButton(
              //           onPressed: () {
              //             popUpAddData();
              //           },
              //           icon: const Icon(
              //             CupertinoIcons.add,
              //             color: Colors.white60,
              //           ),
              //         ),
              // )
            ],
          ),
          body: Obx(
            () => siswaController.isLoading.value == true
                ? Container()
                : siswaController.personsV2.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white54,
                                child: Text(
                                  "${index + 1}",
                                  style: kDefaultTextStyle(
                                      fontSize: 18, color: Colors.black87),
                                ),
                              ),
                              title: Text(
                                siswaController.personsV2[index]['siswa_nama']
                                    .toString(),
                                style: kDefaultTextStyle(fontSize: 15),
                              ),
                              subtitle: Text(
                                  "NIS : ${siswaController.personsV2[index]['siswa_nis']}",
                                  style: kDefaultTextStyle(fontSize: 13)),
                              trailing: Text(
                                "Gender : ${siswaController.personsV2[index]['gender']}",
                                style: kDefaultTextStyle(fontSize: 12),
                              ),
                            ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: siswaController.personsV2.length)
                    : Center(
                        child: Text(
                          "Tidak ada data",
                          style: kDefaultTextStyle(fontSize: 16),
                        ),
                      ),
          ),
        ),
        Obx(() => siswaController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}
