import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';

import 'detail_siswa_hadir.dart';

class AbsensiPage extends StatefulWidget {
  final String? kelas;
  final int? index;
  const AbsensiPage({super.key, this.kelas, this.index});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  LocationController locationController = Get.find();
  AccountsController accountsController = Get.find();
  SiswaController siswaController = Get.find();
  TextEditingController namaController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    nisController.dispose();
    keteranganController.dispose();
    jenisKelaminController.dispose();
    super.dispose();
  }

  void popUpAddData() {
    Get.defaultDialog(
        content: Column(
          children: [
            Text(
              "Tambah data secara manual untuk siswa tidak hadir, izin, atau terlambat. \nAturan keterangan (Masuk = 1, Izin = 2, Sakit = 3, Tidak Diketahui = 4)",
              style: kDefaultTextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: namaController,
              placeholderStyle: const TextStyle(color: Colors.black38),
              placeholder: "Nama",
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.person, color: Colors.black26),
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              controller: nisController,
              placeholderStyle: const TextStyle(color: Colors.black38),
              placeholder: "NIS",
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.person_crop_square,
                    color: Colors.black26),
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              controller: keteranganController,
              keyboardType: const TextInputType.numberWithOptions(),
              placeholderStyle: const TextStyle(color: Colors.black38),
              placeholder: "Keterangan",
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.news, color: Colors.black26),
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              controller: jenisKelaminController,
              placeholderStyle: const TextStyle(color: Colors.black38),
              placeholder: "Jenis Kelamin",
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child:
                    Icon(CupertinoIcons.personalhotspot, color: Colors.black26),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade900,
        titleStyle:
            kDefaultTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        title: "Tambah Manual",
        barrierDismissible: true,
        buttonColor: Colors.green,
        textConfirm: siswaController.isLoadingDaftarKelas.value == true
            ? "Loading..."
            : "Tambah",
        contentPadding: const EdgeInsets.all(10),
        onConfirm: () async {
          if (namaController.text.isNotEmpty &&
              nisController.text.isNotEmpty &&
              keteranganController.text.isNotEmpty &&
              jenisKelaminController.text.isNotEmpty) {
            List<Map<String, dynamic>> dataManual = [];
            dataManual.add({
              'siswa_nama': namaController.text,
              'siswa_nis': nisController.text,
              'guru_id':
                  accountsController.guruModels.value?.data.guruId ?? '0',
              'keterangan': keteranganController.text,
              'gender': jenisKelaminController.text,
              'longitude': locationController.longitude.value,
              'latitude': locationController.latitude.value,
              'location': locationController.currentAddress.value
            });
            if (await siswaController.tambahDataManual(
                    absenManual: dataManual) ==
                true) {
              dataManual.clear();
              Future.delayed(Duration.zero, () {
                Navigator.pop(context);
              });
            } else {
              Future.delayed(Duration.zero, () {
                Navigator.pop(context);
              });
            }
          } else {
            Navigator.pop(context);
            Get.snackbar('Gagal', "Mohon isi semua data form",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Absensi Kelas ${widget.kelas}",
              style: kDefaultTextStyle(fontSize: 16),
            ),
            actions: [
              IconButton(
                tooltip: "Tambah Data",
                onPressed: () {
                  popUpAddData();
                },
                icon: const Icon(
                  CupertinoIcons.add,
                  color: CupertinoColors.activeBlue,
                ),
              ),
              Obx(
                () => siswaController.isLoadingDaftarKelas.value == true
                    ? Container()
                    : IconButton(
                        tooltip: "Refesh",
                        onPressed: () {
                          siswaController.daftarKelasHariIni(
                              guruID: accountsController
                                      .guruModels.value?.data.guruId ??
                                  '0');
                        },
                        icon: const Icon(
                          CupertinoIcons.refresh,
                          color: CupertinoColors.activeBlue,
                        )),
              )
            ],
          ),
          backgroundColor: Colors.black,
          body: Obx(
            () => siswaController.daftarKelasModels.value != null
                ? ListView.separated(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    itemBuilder: (c, i) => ListTile(
                          dense: false,
                          onTap: () {
                            Get.to(
                              () => DetailSiswa(
                                namaSiswa: siswaController
                                    .daftarKelasModels
                                    .value
                                    ?.data[widget.index!]
                                    .siswa?[i]
                                    .siswaNama,
                                jamHadir: DateFormat('dd MMM yyyy -')
                                    .add_jm()
                                    .format(siswaController
                                                .daftarKelasModels
                                                .value!
                                                .data[widget.index!]
                                                .siswa?[i]
                                                .absenDatetime !=
                                            null
                                        ? DateTime.parse(siswaController
                                            .daftarKelasModels
                                            .value!
                                            .data[widget.index!]
                                            .siswa![i]
                                            .absenDatetime!)
                                        : DateTime.now()),
                                jenisKelamin: siswaController
                                        .daftarKelasModels
                                        .value!
                                        .data[widget.index!]
                                        .siswa?[i]
                                        .siswaGender ??
                                    'Unknown',
                                kelas: widget.kelas ?? "Unknown",
                              ),
                            );
                          },
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.white24, shape: BoxShape.circle),
                            child: const Center(
                                child: Icon(
                              CupertinoIcons.person_alt,
                              size: 30,
                              color: Colors.white,
                            )),
                          ),
                          title: Text(
                            siswaController.daftarKelasModels.value
                                    ?.data[widget.index!].siswa?[i].siswaNama ??
                                'Tidak ada nama',
                            style: kDefaultTextStyleBold(fontSize: 17),
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.time_solid,
                                size: 17,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                  "${DateFormat().add_jm().format(DateTime.parse(siswaController.daftarKelasModels.value!.data[widget.index!].siswa![i].absenDatetime!))} | Status : ",
                                  style:
                                      kDefaultTextStyle(color: Colors.white60)),
                              if (siswaController
                                      .daftarKelasModels
                                      .value
                                      ?.data[widget.index!]
                                      .siswa![i]
                                      .absenStatus ==
                                  "1")
                                Text("Hadir",
                                    style:
                                        kDefaultTextStyle(color: Colors.green))
                              else if (siswaController
                                      .daftarKelasModels
                                      .value
                                      ?.data[widget.index!]
                                      .siswa![i]
                                      .absenStatus ==
                                  "2")
                                Text("Izin",
                                    style:
                                        kDefaultTextStyle(color: Colors.blue))
                              else if (siswaController
                                      .daftarKelasModels
                                      .value
                                      ?.data[widget.index!]
                                      .siswa![i]
                                      .absenStatus ==
                                  "3")
                                Text("Sakit",
                                    style:
                                        kDefaultTextStyle(color: Colors.orange))
                              else if (siswaController
                                      .daftarKelasModels
                                      .value
                                      ?.data[widget.index!]
                                      .siswa![i]
                                      .absenStatus ==
                                  "2")
                                Text("Tidak Diketahui",
                                    style: kDefaultTextStyle(color: Colors.red))
                            ],
                          ),
                          trailing: SizedBox(
                            height: double.infinity,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white38,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Colors.white54,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: siswaController.daftarKelasModels.value!
                        .data[widget.index!].siswa!.length)
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/images/no_data.json', height: 110),
                        const SizedBox(height: 10),
                        Text(
                          "Tidak ada data absen hari ini",
                          style: kDefaultTextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Obx(() => siswaController.isLoadingDaftarKelas.value == true ||
                siswaController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}
