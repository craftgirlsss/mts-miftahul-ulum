import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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

class _AbsensiPageState extends State<AbsensiPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  LocationController locationController = Get.find();
  AccountsController accountsController = Get.find();
  SiswaController siswaController = Get.find();
  TextEditingController namaController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  var itemData = [1, 2, 3];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

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
        textConfirm: "Tambah",
        contentPadding: const EdgeInsets.all(10),
        onConfirm: () async {
          List<Map<String, dynamic>> dataManual = [];
          dataManual.add({
            'siswa_nama': namaController.text,
            'siswa_nis': nisController.text,
            'guru_id': accountsController.guruModels.value?.data.guruId ?? '0',
            'keterangan': keteranganController.text,
            'gender': jenisKelaminController.text,
            'longitude': locationController.longitude.value,
            'latitude': locationController.latitude.value,
            'location': locationController.currentAddress.value
          });
          if (await siswaController.tambahDataManual(absenManual: dataManual) ==
              true) {
            dataManual.clear();
            Get.back();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // String? statusAbsen;
    return Scaffold(
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
              ))
        ],
      ),
      backgroundColor: Colors.black,
      body: Obx(
        () => siswaController.daftarKelasModels.value != null
            ? ListView.separated(
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemBuilder: (c, i) => (i !=
                        siswaController.daftarKelasModels.value!
                            .data[widget.index!].siswa!.length)
                    ? ListTile(
                        dense: false,
                        onTap: () {
                          Get.to(() => DetailSiswa(
                                namaSiswa: "Ruthalia Anwira Maya",
                                jamHadir: DateFormat('dd MMM yyyy -')
                                    .add_jm()
                                    .format(DateTime.parse(siswaController
                                        .daftarKelasModels
                                        .value!
                                        .data[widget.index!]
                                        .siswa![i]
                                        .absenTimestamp!)),
                                jenisKelamin: "Perempuan",
                                kelas: "9C",
                              ));
                        },
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.purple, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              (i + 1).toString(),
                              style: kDefaultTextStyle(),
                            ),
                          ),
                        ),
                        title: Text(
                          siswaController.daftarKelasModels.value
                                  ?.data[widget.index!].siswa![i].siswaNama ??
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
                                "${DateFormat().add_jm().format(DateTime.parse(siswaController.daftarKelasModels.value!.data[widget.index!].siswa![i].absenDatetime!))} | Status : ${siswaController.daftarKelasModels.value?.data[widget.index!].siswa![i].absenStatus}"),
                          ],
                        ),
                        trailing: SizedBox(
                          height: double.infinity,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white38, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: Colors.white54,
                              size: 22,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Text(
                              "Pengertian Status\nHadir = 1\nIzin = 2\nSakit = 3\nTidak Diketahui = 4",
                              textAlign: TextAlign.center,
                              style: kDefaultTextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                separatorBuilder: (c, i) => const SizedBox(height: 0),
                itemCount: siswaController.daftarKelasModels.value!
                        .data[widget.index!].siswa!.length +
                    1)
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
    );
  }
}
