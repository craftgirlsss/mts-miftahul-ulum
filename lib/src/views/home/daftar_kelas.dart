import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';
import 'package:socio_univ/src/views/home/absensi.dart';

class DaftarKelas extends StatefulWidget {
  const DaftarKelas({super.key});

  @override
  State<DaftarKelas> createState() => _DaftarKelasState();
}

class _DaftarKelasState extends State<DaftarKelas> {
  SiswaController siswaController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Daftar Kelas",
                        style: kDefaultTextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Obx(() => siswaController.isLoadingDaftarKelas.value == true
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.5,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      : siswaController.daftarKelasModels.value?.data.length ==
                              null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.5,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          color: Colors.white54,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          (i + 1).toString(),
                                          style: kDefaultTextStyle(
                                              color: Colors.black54,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "Kelas ${siswaController.daftarKelasModels.value?.data[i].kelasNama ?? '-'}",
                                      style:
                                          kDefaultTextStyleBold(fontSize: 17),
                                    ),

                                    subtitle: Text(
                                      "Masuk 27, Izin 2, Sakit 1, Tanpa Keterangan 1",
                                      overflow: TextOverflow.clip,
                                      style: kDefaultTextStyle(
                                          fontSize: 10, color: Colors.white54),
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
                              separatorBuilder: (c, i) =>
                                  const SizedBox(height: 0),
                              itemCount: siswaController
                                      .daftarKelasModels.value?.data.length ??
                                  0)),
                ],
              ),
            ),
          ),
        ),
        Obx(() => siswaController.isLoadingDaftarKelas.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}
