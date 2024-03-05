import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socio_univ/src/models/daftar_kelas_models.dart';
import 'package:socio_univ/src/models/siswa_models.dart';

import '../models/daftar_absensi_guru_models.dart';

class SiswaController extends GetxController {
  var isLoading = false.obs;
  var isLoadingDaftarKelas = false.obs;
  var siswaModels = Rxn<SiswaModels>();
  var daftarKelasModels = Rxn<DaftarKelasModels>();
  var daftarGuruAbsenModels = Rxn<AbsensiGuruModels>();
  List<Map<String, dynamic>> personsV2 = [];

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

  daftarAbsenGuruHariIni() async {
    try {
      isLoadingDaftarKelas(true);
      http.Response response = await http.get(
          Uri.tryParse("https://api.miftahululumts.sch.id/guru/today")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        isLoadingDaftarKelas(false);
          daftarGuruAbsenModels.value =
              AbsensiGuruModels.fromJson(jsonDecode(response.body));
      } else {
        Get.snackbar("Gagal",
            "Gagal menghubungkan ke server karna kode ${response.statusCode}",
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
    if (personsV2.isEmpty) {
      Get.snackbar(
          "Informasi", "Gagal, data kosong karna anda telah menghapusnya",
          backgroundColor: Colors.white, colorText: Colors.black87);
      return false;
    } else {
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
          personsV2.clear();
          print(jsonDecode(response.body));
          isLoading(false);
          if (jsonDecode(response.body)['success'] == true) {
            print(jsonDecode(response.body)['message']);
            Get.snackbar("Berhasil", jsonDecode(response.body)['message'],
                backgroundColor: Colors.white,
                colorText: Colors.black87,
                duration: const Duration(seconds: 4));
            return true;
          } else if (jsonDecode(response.body)['success'] == false) {
            print(jsonDecode(response.body)['message']);
            Get.snackbar("Gagal",
                "Mohon cek kembali siswa apakah sudah terabsen atau belum, status : ${jsonDecode(response.body)['message']}",
                backgroundColor: Colors.red, colorText: Colors.white);
            isLoading(false);
            return false;
          } else {
            debugPrint("masuk ke Else");
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
