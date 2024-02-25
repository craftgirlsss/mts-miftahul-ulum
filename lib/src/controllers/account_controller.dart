import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_univ/main.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';
import 'package:socio_univ/src/models/get_guru_for_absen.dart';
import 'package:socio_univ/src/models/guru_models.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/alert.dart';

class AccountsController extends GetxController {
  var isLoading = false.obs;
  var guruModels = Rxn<GuruModels>();
  var guruModelsForAbsence = Rxn<GuruModelsForAbsence>();
  SiswaController siswaController = Get.put(SiswaController());
  var guruID = ''.obs;
  List<Map<String, dynamic>> daftarAbsenceTempGuru = [];

  Future<bool> loginGuru(context, {String? nip, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse("https://api.miftahululumts.sch.id/auth/login")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          },
          body: {
            'nip': nip,
            'password': password,
          }).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['version'] != versionAPP) {
          showAlertDialogUpdate(context,
              canDissmisable: false,
              title: "Pembaruan Aplikasi",
              description:
                  "Aplikasi tidak dapat digunakan, mohon untuk mendownload aplikasi terbaru ke situs resmi MTs",
              onOk: () {
            launchUrl(Uri.parse('https://miftahululumts.sch.id/'));
          });
          return false;
        } else {
          if (jsonDecode(response.body)['success'] == true) {
            prefs.setBool('login', true);
            guruModels.value = GuruModels.fromJson(jsonDecode(response.body));
            prefs.setString(
                'nip', jsonDecode(response.body)['data']['guru_nip']);
            prefs.setString(
                'guruID', jsonDecode(response.body)['data']['guru_id']);
            await siswaController.daftarKelasHariIni(
                guruID: jsonDecode(response.body)['data']['guru_id']);
            Get.snackbar("Berhasil",
                "Berhasil masuk, Anda akan diarahkan ke halaman homepage",
                backgroundColor: Colors.white, colorText: Colors.black87);
            return true;
          } else {
            Get.snackbar(
                "Gagal", "Gagal masuk, NIP tidak ditemukan atau password salah",
                backgroundColor: Colors.red, colorText: Colors.white);
            isLoading(false);
            return false;
          }
        }
      } else {
        Get.snackbar("Gagal",
            "Gagl menghubungkan ke server karna kode ${response.statusCode}",
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  // http://localhost/api-mts/auth/getGuruInfo
  Future<bool> getDataPengajar(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse("https://api.miftahululumts.sch.id/auth/getGuruInfo")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          },
          body: {
            'nip': prefs.getString('nip'),
          }).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['version'] != versionAPP) {
          showAlertDialogUpdate(context,
              canDissmisable: false,
              title: "Pembaruan Aplikasi",
              description:
                  "Aplikasi tidak dapat digunakan, mohon untuk mendownload aplikasi terbaru ke situs resmi MTs",
              onOk: () {
            launchUrl(Uri.parse(jsonDecode(response.body)['download'] ??
                'https://miftahululumts.sch.id'));
          });
          return false;
        } else {
          if (jsonDecode(response.body)['success'] == true) {
            guruModels.value = GuruModels.fromJson(jsonDecode(response.body));
            siswaController.daftarKelasHariIni(
                guruID: jsonDecode(response.body)['data']['guru_id']);
            return true;
          } else {
            Get.snackbar("Gagal",
                "Gagal masuk, status json ${json.decode(response.body)['success']}",
                backgroundColor: Colors.red, colorText: Colors.white);
            isLoading(false);
            return false;
          }
        }
      } else {
        Get.snackbar("Gagal",
            "Gagal masuk, Satatus ${json.decode(response.body)['success']}",
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading(false);
        return false;
      }
    } on TimeoutException catch (e) {
      isLoading(false);
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  // http://localhost/api-mts/auth/getGuruInfo
  Future<bool> getDataPengajarForAbsence(context, {String? nip}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse("https://api.miftahululumts.sch.id/auth/getGuruInfo")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          },
          body: {
            'nip': nip,
          }).timeout(const Duration(seconds: 15));
      isLoading(false);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'] == true) {
          guruModelsForAbsence.value =
              GuruModelsForAbsence.fromJson(jsonDecode(response.body));
          return true;
        } else {
          Get.snackbar("Gagal",
              "Data guru tidak dapat ditemukan, mohon konfirmasi ke admin",
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
      } else {
        isLoading(false);
        Get.snackbar("Gagal",
            "Gagal masuk, Satatus ${json.decode(response.body)['success']}",
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } on TimeoutException catch (e) {
      isLoading(false);
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  Future<bool> forgotPassword({String? email}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse(
              "https://api.miftahululumts.sch.id/auth/forgotPassword")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          },
          body: {
            'email': email,
          });

      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['success'] == true) {
          Get.snackbar("Berhasil",
              "Berhasil mengirim email. Silahkan cek email anda untuk melihat password baru",
              backgroundColor: Colors.white, colorText: Colors.black87);
          return true;
        } else {
          Get.snackbar("Gagal",
              "Gagl menghubungkan ke server karna kode ${jsonDecode(response.body)['message']}",
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

  Future<bool> changePassword({String? newPassword, String? guruID}) async {
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse(
              "https://api.miftahululumts.sch.id/auth/changePassword")!,
          headers: {
            'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
          },
          body: {
            'guruID': guruID,
            'new_password': newPassword,
          });

      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['success'] == true) {
          Get.snackbar("Berhasil", jsonDecode(response.body)['message'],
              backgroundColor: Colors.white, colorText: Colors.black87);
          return true;
        } else {
          Get.snackbar("Gagal", jsonDecode(response.body)['message'],
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

  clearingDataTemp() {
    isLoading.value = true;
    daftarAbsenceTempGuru.clear();
    isLoading.value = false;
  }

// Ini perlu dirubah karna API belum tersedia
  Future<bool> finishAbsensiGuru() async {
    if (daftarAbsenceTempGuru.isEmpty) {
      Get.snackbar(
          "Informasi", "Gagal, data kosong karna anda telah menghapusnya",
          backgroundColor: Colors.white, colorText: Colors.black87);
      return false;
    } else {
      try {
        isLoading(true);

        http.Response response = await http.post(
            Uri.tryParse("https://api.miftahululumts.sch.id/guru/absen")!,
            headers: {
              'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
            },
            body: {
              'dump': jsonEncode(daftarAbsenceTempGuru),
            });

        if (response.statusCode == 200) {
          daftarAbsenceTempGuru.clear();
          isLoading(false);
          if (jsonDecode(response.body)['success'] == true) {
            Get.snackbar(
              "Informasi",
              "Berhasil mengirim data absensi guru, ${jsonDecode(response.body)['message']}",
              backgroundColor: Colors.white,
              colorText: Colors.black87,
            );
            return true;
          } else if (jsonDecode(response.body)['success'] == false) {
            Get.snackbar("Informasi", "${jsonDecode(response.body)['message']}",
                backgroundColor: Colors.white, colorText: Colors.black87);
            isLoading(false);
            return false;
          } else {
            debugPrint("masuk ke Else");
            return false;
          }
        } else {
          isLoading(false);
          Get.snackbar("Informasi",
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
}
