import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';
import 'package:socio_univ/src/views/home/absensi.dart';

class DaftarKelas extends StatefulWidget {
  const DaftarKelas({super.key});

  @override
  State<DaftarKelas> createState() => _DaftarKelasState();
}

class _DaftarKelasState extends State<DaftarKelas> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nisController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  SiswaController siswaController = Get.find();
  AccountsController accountsController = Get.find();
  LocationController locationController = Get.find();

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
              keyboardType: const TextInputType.numberWithOptions(),
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
              keyboardType: const TextInputType.numberWithOptions(
                decimal: false,
              ),
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
              placeholder: "Jenis Kelamin (P/L)",
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
              keteranganController.clear();
              namaController.clear();
              nisController.clear();
              jenisKelaminController.clear();
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
  void initState() {
    siswaController.daftarAbsenGuruHariIni();
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              siswaController.daftarKelasHariIni(
                  guruID:
                      accountsController.guruModels.value?.data.guruId ?? '0');
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Daftar Absensi",
                  style: kDefaultTextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                bottom: const TabBar(
                    labelColor: CupertinoColors.activeBlue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: CupertinoColors.activeBlue,
                    dividerColor: Colors.white12,
                    tabs: [
                      Tab(text: "Absensi Siswa"),
                      Tab(text: "Absensi Guru"),
                    ]),
              ),
              backgroundColor: Colors.black,
              body: TabBarView(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Daftar Kelas",
                                style: kDefaultTextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
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
                                      () => siswaController
                                                  .isLoadingDaftarKelas.value ==
                                              true
                                          ? Container()
                                          : IconButton(
                                              tooltip: "Refesh",
                                              onPressed: () {
                                                siswaController
                                                    .daftarKelasHariIni(
                                                        guruID:
                                                            accountsController
                                                                    .guruModels
                                                                    .value
                                                                    ?.data
                                                                    .guruId ??
                                                                '0');
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.refresh,
                                                color:
                                                    CupertinoColors.activeBlue,
                                              )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() => siswaController
                                      .isLoadingDaftarKelas.value ==
                                  true
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset('assets/images/no_data.json',
                                          height: 110),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Tidak ada data absen hari ini",
                                        style: kDefaultTextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              : siswaController.daftarKelasModels.value?.data
                                          .length ==
                                      0
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'assets/images/no_data.json',
                                              frameRate: const FrameRate(50),
                                              repeat: false,
                                              height: 110),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Tidak ada data absen hari ini",
                                            style:
                                                kDefaultTextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemBuilder: (c, i) => ListTile(
                                            dense: false,
                                            // enableFeedback: false,
                                            isThreeLine: true,
                                            onTap: () {
                                              Get.to(() => AbsensiPage(
                                                    index: i,
                                                    kelas: siswaController
                                                            .daftarKelasModels
                                                            .value
                                                            ?.data[i]
                                                            .kelasNama ??
                                                        '-',
                                                  ));
                                            },
                                            leading: Container(
                                              width: 44,
                                              height: 44,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/class.png'))),
                                            ),
                                            title: Text(
                                              "Kelas ${siswaController.daftarKelasModels.value?.data[i].kelasNama ?? '-'}",
                                              style: kDefaultTextStyleBold(
                                                  fontSize: 17),
                                            ),

                                            subtitle: Text(
                                              "Jumlah siswa terabsensi ${siswaController.daftarKelasModels.value?.data[i].siswa?.length ?? 0}",
                                              overflow: TextOverflow.clip,
                                              style: kDefaultTextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white54),
                                            ),
                                            trailing: SizedBox(
                                              height: double.infinity,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white38,
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                  color: Colors.white54,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (c, i) =>
                                          const SizedBox(height: 0),
                                      itemCount: siswaController
                                              .daftarKelasModels
                                              .value
                                              ?.data
                                              .length ??
                                          0)),
                          // siswaController.daftarKelasModels.value?.data.length != 0
                          //     ? kDefaultButtons(
                          //         backgroundColor: Colors.green,
                          //         onPressed: () {},
                          //         textColor: Colors.white,
                          //         title: "Lihat Daftar Guru")
                          //     : Container()
                        ],
                      ),
                    ),
                  ),

                  // daftar hadir guru
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Daftar Guru",
                                style: kDefaultTextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
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
                                      () => siswaController
                                                  .isLoadingDaftarKelas.value ==
                                              true
                                          ? Container()
                                          : IconButton(
                                              tooltip: "Refesh",
                                              onPressed: () {
                                                siswaController
                                                    .daftarKelasHariIni(
                                                        guruID:
                                                            accountsController
                                                                    .guruModels
                                                                    .value
                                                                    ?.data
                                                                    .guruId ??
                                                                '0');
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.refresh,
                                                color:
                                                    CupertinoColors.activeBlue,
                                              )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() => siswaController
                                      .isLoadingDaftarKelas.value ==
                                  true
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset('assets/images/no_data.json',
                                          height: 110),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Tidak ada data absen hari ini",
                                        style: kDefaultTextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              : siswaController.daftarKelasModels.value?.data
                                          .length ==
                                      0
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                              'assets/images/no_data.json',
                                              frameRate: const FrameRate(50),
                                              repeat: false,
                                              height: 110),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Tidak ada data absen hari ini",
                                            style:
                                                kDefaultTextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemBuilder: (c, i) => ListTile(
                                            dense: false,
                                            // enableFeedback: false,
                                            isThreeLine: true,
                                            onTap: () {
                                              Get.to(() => AbsensiPage(
                                                    index: i,
                                                    kelas: siswaController
                                                            .daftarKelasModels
                                                            .value
                                                            ?.data[i]
                                                            .kelasNama ??
                                                        '-',
                                                  ));
                                            },
                                            leading: Container(
                                              width: 44,
                                              height: 44,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/class.png'))),
                                            ),
                                            title: Text(
                                              "Kelas ${siswaController.daftarKelasModels.value?.data[i].kelasNama ?? '-'}",
                                              style: kDefaultTextStyleBold(
                                                  fontSize: 17),
                                            ),

                                            subtitle: Text(
                                              "Jumlah siswa terabsensi ${siswaController.daftarKelasModels.value?.data[i].siswa?.length ?? 0}",
                                              overflow: TextOverflow.clip,
                                              style: kDefaultTextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white54),
                                            ),
                                            trailing: SizedBox(
                                              height: double.infinity,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white38,
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                  color: Colors.white54,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (c, i) =>
                                          const SizedBox(height: 0),
                                      itemCount: siswaController
                                              .daftarKelasModels
                                              .value
                                              ?.data
                                              .length ??
                                          0)),
                          // siswaController.daftarKelasModels.value?.data.length != 0
                          //     ? kDefaultButtons(
                          //         backgroundColor: Colors.green,
                          //         onPressed: () {},
                          //         textColor: Colors.white,
                          //         title: "Lihat Daftar Guru")
                          //     : Container()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => siswaController.isLoadingDaftarKelas.value == true
              ? floatingLoading()
              : const SizedBox()),
        ],
      ),
    );
  }
}
