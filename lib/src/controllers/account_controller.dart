import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socio_univ/src/controllers/siswa_controller.dart';
import 'package:socio_univ/src/models/guru_models.dart';

class AccountsController extends GetxController {
  var isLoading = false.obs;
  var guruModels = Rxn<GuruModels>();
  SiswaController siswaController = Get.put(SiswaController());
  var guruID = ''.obs;

  Future<bool> loginGuru({String? nip, String? password}) async {
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
        // print(jsonDecode(response.body));
        if (jsonDecode(response.body)['success'] == true) {
          prefs.setBool('login', true);
          guruModels.value = GuruModels.fromJson(jsonDecode(response.body));
          prefs.setString('nip', jsonDecode(response.body)['data']['guru_nip']);
          siswaController.daftarKelasHariIni(
              guruID: jsonDecode(response.body)['data']['guru_id']);
          Get.snackbar("Berhasil",
              "Berhasil masuk, Anda akan diarahkan ke halaman homepage",
              backgroundColor: Colors.white, colorText: Colors.black87);
          return true;
        } else {
          Get.snackbar("Gagal",
              "Gagal masuk, status json ${json.decode(response.body)['success']}",
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
    } catch (e) {
      isLoading(false);
      Get.snackbar("Gagal", "$e",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  // http://localhost/api-mts/auth/getGuruInfo
  Future<bool> getDataPengajar() async {
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
        if (jsonDecode(response.body)['success'] == true) {
          // prefs.setString(
          //     'guru_id', jsonDecode(response.body)['data']['guru_id']);
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
              "Gagl menghubungkan ke server karna kode ${response.statusCode}",
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
