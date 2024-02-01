import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socio_univ/src/components/styles.dart';

import 'detail_siswa_hadir.dart';
import 'detail_siswa_tidak_hadir.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var itemData = [1, 2, 3];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 700),
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Daftar Hadir",
            style: kDefaultTextStyleBold(fontSize: 19),
          ),
          bottom: const TabBar(
              enableFeedback: true,
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.white24,
              tabs: [
                Tab(icon: Text("Hadir")),
                Tab(icon: Text("Telat")),
                Tab(icon: Text("Tidak Hadir")),
              ]),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: 50,
              color: Colors.white12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kelas : 9A",
                    style: kDefaultTextStyle(color: Colors.white),
                  ),
                  Text(
                    "Jumlah Siswa : 19/28",
                    style: kDefaultTextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // daftar siswa hadir
                  ListView.separated(
                      itemBuilder: (c, i) => (i != itemData.length)
                          ? ListTile(
                              // enableFeedback: false,
                              onTap: () {
                                Get.to(() => DetailSiswa(
                                      namaSiswa: "Ruthalia Anwira Maya",
                                      jamHadir: DateFormat('dd MMM yyyy -')
                                          .add_jm()
                                          .format(DateTime.now()),
                                      jenisKelamin: "Perempuan",
                                      kelas: "9C",
                                    ));
                              },
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    (i + 1).toString(),
                                    style: kDefaultTextStyle(),
                                  ),
                                ),
                              ),
                              title: Text(
                                "Student ${i + 1}",
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
                                  Text(DateFormat('dd MMM yyyy -')
                                      .add_jm()
                                      .format(DateTime.now())),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 24,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Center(
                                child: Text(
                                  "Jumlah siswa hadir : $i/28",
                                  style: kDefaultTextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                      separatorBuilder: (c, i) => const SizedBox(height: 10),
                      itemCount: itemData.length + 1),

                  // Daftar siswa telat
                  ListView.separated(
                      itemBuilder: (c, i) => (i != itemData.length)
                          ? ListTile(
                              // enableFeedback: false,
                              onTap: () {
                                // Get.to(() => const ConfirmationPage());
                              },
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    (i + 1).toString(),
                                    style: kDefaultTextStyle(),
                                  ),
                                ),
                              ),
                              title: Text(
                                "Student ${i + 1}",
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
                                  Text(DateFormat('dd MMM yyyy |')
                                      .add_jm()
                                      .format(DateTime.now())),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 24,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Center(
                                child: Text(
                                  "Jumlah siswa telat : $i/28",
                                  style: kDefaultTextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                      separatorBuilder: (c, i) => const SizedBox(height: 10),
                      itemCount: itemData.length + 1),

                  // Daftar siswa tidak hadir
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: ListView.separated(
                        itemBuilder: (c, i) => (i != itemData.length)
                            ? ListTile(
                                // enableFeedback: false,
                                onTap: () {
                                  Get.to(() => const DetailSiswaTidakHadir(
                                        namaSiswa: "Arum Purwita Sari",
                                        alasan: "Sakit",
                                        jenisKelamin: "Perempuan",
                                        kelas: "9C",
                                      ));
                                },
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.purple,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Text(
                                      "${i + 1}",
                                      style: kDefaultTextStyle(),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Student ${i + 1}",
                                  style: kDefaultTextStyleBold(fontSize: 17),
                                ),
                                subtitle: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Alasan : "),
                                    Text(
                                      "Sakit",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 24,
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Jumlah siswa tidak hadir : $i/28",
                                  style: kDefaultTextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                        separatorBuilder: (c, i) => const SizedBox(height: 7),
                        itemCount: itemData.length + 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
