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
                    : TextButton(
                        onPressed: () {
                          showAlertDialog(context,
                              description:
                                  "Apakah anda yakin menghapus semua data?",
                              onOk: () {
                            siswaController.clearingDataTemp();
                            Navigator.pop(context);
                          }, title: "Hapus");
                        },
                        child: const Text("Delete All", style: TextStyle(color: CupertinoColors.destructiveRed),)
                      ),
              ),
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
                                    trailing: IconButton(onPressed: (){
                                      showAlertDialog(context,
                                    description:
                                        "Apakah anda yakin menghapus data absensi ${siswaController.personsV2[index]['siswa_nama']}?",
                                    onOk: () {
                                        setState(() {
                                          siswaController.personsV2.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      }, 
                                    title: "Hapus");    
                                    }, 
                                    icon: const Icon(CupertinoIcons.trash, color: Colors.white60,))
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
