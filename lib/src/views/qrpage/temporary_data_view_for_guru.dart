import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/alert.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/controllers/location_controller.dart';

class TemporaryDataViewForGuru extends StatefulWidget {
  const TemporaryDataViewForGuru({super.key});

  @override
  State<TemporaryDataViewForGuru> createState() =>
      _TemporaryDataViewForGuruState();
}

class _TemporaryDataViewForGuruState extends State<TemporaryDataViewForGuru> {
  LocationController locationController = Get.find();
  AccountsController accountsController = Get.find();
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
                () => accountsController.isLoading.value == true
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          showAlertDialog(context,
                              description:
                                  "Apakah anda yakin menghapus semua data?",
                              onOk: () {
                            accountsController.clearingDataTemp();
                            Navigator.pop(context);
                          }, title: "Hapus");
                        },
                        child: const Text("Delete All", style: TextStyle(color: CupertinoColors.destructiveRed),)
                      ),
              ),
            ],
          ),
          body: Obx(
            () => accountsController.isLoading.value == true
                ? Container()
                : accountsController.daftarAbsenceTempGuru.isNotEmpty
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
                                accountsController.daftarAbsenceTempGuru[index]
                                        ['guru_nama']
                                    .toString(),
                                style: kDefaultTextStyle(fontSize: 15),
                              ),
                              subtitle: Text(
                                  "NIP : ${accountsController.daftarAbsenceTempGuru[index]['guru_nip']}",
                                  style: kDefaultTextStyle(fontSize: 13)),
                              trailing: IconButton(onPressed: (){
                                      showAlertDialog(context,
                                    description:
                                        "Apakah anda yakin menghapus data absensi ${accountsController.daftarAbsenceTempGuru[index]['guru_nama']}?",
                                    onOk: () {
                                        setState(() {
                                          accountsController.daftarAbsenceTempGuru.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      }, 
                                    title: "Hapus");    
                                    }, 
                                    icon: const Icon(CupertinoIcons.trash, color: Colors.white60,))
                            ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount:
                            accountsController.daftarAbsenceTempGuru.length)
                    : Center(
                        child: Text(
                          "Tidak ada data",
                          style: kDefaultTextStyle(fontSize: 16),
                        ),
                      ),
          ),
        ),
        Obx(() => accountsController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}
