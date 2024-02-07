import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socio_univ/src/models/daftar_kelas_models.dart';
import 'package:socio_univ/src/models/siswa_models.dart';

class SiswaController extends GetxController {
  var isLoading = false.obs;
  var isLoadingDaftarKelas = false.obs;
  // AccountsController accountsController = Get.put(AccountsController());
  var siswaModels = Rxn<SiswaModels>();
  var daftarKelasModels = Rxn<DaftarKelasModels>();
  List<Map<String, dynamic>> personsV2 = [];
  var hadir = 0.obs;
  var izin = 0.obs;
  var sakit = 0.obs;
  var tidakDiketahui = 0.obs;
  // RxList personsV2 = [].obs;

  daftarKelasHariIni({String? guruID}) async {
    try {
      isLoadingDaftarKelas(true);
      http.Response response = await http.get(
          Uri.tryParse(
              "https://api.miftahululumts.sch.id/get_all?guru_id=$guruID")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        isLoadingDaftarKelas(false);
        if (jsonDecode(response.body)['success'] == true) {
          daftarKelasModels.value =
              DaftarKelasModels.fromJson(jsonDecode(response.body));

          // for (int i = 0; i < daftarKelasModels.value!.data.length; i++) {
          //   for (int j = i;
          //       j < daftarKelasModels.value!.data[i].siswa!.length;
          //       j++) {
          //     if (daftarKelasModels.value!.data[i].siswa?[j].absenStatus ==
          //         '1') {
          //       hadir.value + 1;
          //       print(hadir.value);
          //     } else if (daftarKelasModels
          //             .value!.data[i].siswa?[j].absenStatus ==
          //         '2') {
          //       izin.value + 1;
          //       print(izin.value);
          //     } else if (daftarKelasModels
          //             .value!.data[i].siswa?[j].absenStatus ==
          //         '3') {
          //       sakit.value + 1;
          //       print(sakit.value);
          //     } else if (daftarKelasModels
          //             .value!.data[i].siswa?[j].absenStatus ==
          //         '4') {
          //       tidakDiketahui.value + 1;
          //       print(tidakDiketahui.value);
          //     } else {
          //       print("tidak tahu");
          //     }
          //   }
          // }
          // return true;
        } else {
          Get.snackbar("Gagal",
              "Gagal mendapatkan info siswa, ${json.decode(response.body)['message']}",
              backgroundColor: Colors.red, colorText: Colors.white);
          isLoadingDaftarKelas(false);
          // return false;
        }
      } else {
        Get.snackbar("Gagal",
            "Gagl menghubungkan ke server karna kode ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoadingDaftarKelas(false);
        // return false;
      }
    } on TimeoutException catch (e) {
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoadingDaftarKelas(false);
      return false;
    }
  }

  Future<bool> getDataSiswa({String? nis}) async {
    try {
      isLoading(true);
      http.Response response = await http.get(
          Uri.tryParse("https://api.miftahululumts.sch.id/siswa?nis=$nis")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          }).timeout(const Duration(seconds: 15));

      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        isLoading(false);
        if (jsonDecode(response.body)['success'] == true) {
          siswaModels.value = SiswaModels.fromJson(jsonDecode(response.body));
          return true;
        } else {
          Get.snackbar("Gagal",
              "Gagal mendapatkan info siswa, ${json.decode(response.body)['message']}",
              backgroundColor: Colors.red, colorText: Colors.white);
          isLoading(false);
          return false;
        }
      } else {
        Get.snackbar("Gagal",
            "Gagl menghubungkan ke server karna kode ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading(false);
        return false;
      }
    } on TimeoutException catch (e) {
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading(false);
      return false;
    }
  }

  // clearing data temporary absensi
  clearingDataTemp() {
    isLoading.value = true;
    personsV2.clear();
    isLoading.value = false;
  }

  // post absensi finish
  Future<bool> finishAbsensi() async {
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse("https://api.miftahululumts.sch.id/siswa/absen")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          },
          body: {
            'dump': jsonEncode(personsV2),
          });

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        isLoading(false);
        if (jsonDecode(response.body)['message'] ==
            "1 berhasil absen dan 0 gagal absen.") {
          Get.snackbar("Berhasil", "Berhasil mengirim data absensi",
              backgroundColor: Colors.white, colorText: Colors.black87);
          // daftarKelasHariIni(
          //     guruID: accountsController.guruModels.value?.data.guruId);
          return true;
        } else if (jsonDecode(response.body)['message'] ==
            "0 berhasil absen dan 1 gagal") {
          Get.snackbar("Gagal",
              "Gagl menghubungkan ke server karna kode ${jsonDecode(response.body)['message']}",
              backgroundColor: Colors.red, colorText: Colors.white);
          isLoading(false);
          return false;
        } else {
          print("masuk ke Else");
          return false;
        }
      } else {
        isLoading(false);
        Get.snackbar("Gagal",
            "Gagal masuk, Satatus ${json.decode(response.body)['success']}",
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  // post absensi finish
  Future<bool> tambahDataManual(
      {List<Map<String, dynamic>>? absenManual}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse("https://api.miftahululumts.sch.id/siswa/absen")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          },
          body: {
            'dump': jsonEncode(absenManual),
          });

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        isLoading(false);
        if (jsonDecode(response.body)['success'] == true) {
          Get.snackbar(
              "Berhasil", "Berhasil menambah data absensi secara manual",
              backgroundColor: Colors.white, colorText: Colors.black87);
          return true;
        } else {
          Get.snackbar("Gagal",
              "Gagl menghubungkan ke server karna message ${jsonDecode(response.body)['message']}",
              backgroundColor: Colors.red, colorText: Colors.white);
          isLoading(false);
          return false;
        }
      } else {
        isLoading(false);
        Get.snackbar("Gagal",
            "Gagal masuk, Satatus ${json.decode(response.body)['success']}",
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }
}
