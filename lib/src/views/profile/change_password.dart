import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/custom_textfield.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/helpers/focus.dart';

class GantiPassword extends StatefulWidget {
  const GantiPassword({super.key});

  @override
  State<GantiPassword> createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  AccountsController accountsController = Get.find();
  final passwordbaru1 = TextEditingController();
  final textfield = KTextField();
  bool tampilsandipasswordbaru1 = true;
  bool tampilsandipasswordbaru2 = true;
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  bool hasLowerUpper = false;
  bool isTheSameWithNewPass = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final upperLowerRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');

    setState(() {
      isPasswordEightCharacters = false;
      if (password.length >= 8) isPasswordEightCharacters = true;

      hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) hasPasswordOneNumber = true;
    });
    hasLowerUpper = false;
    if (upperLowerRegex.hasMatch(password)) hasLowerUpper = true;
  }

  @override
  void initState() {
    super.initState();
    passwordbaru1.addListener(() {});
  }

  @override
  void dispose() {
    passwordbaru1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text(
                "Ganti Password",
                style: kDefaultTextStyle(fontSize: 17),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                textfield.passwordinput(
                    obecuretext: tampilsandipasswordbaru1,
                    controller: passwordbaru1,
                    label: "Pasword Baru",
                    onchanged: (text) => onPasswordChanged(text),
                    setstate: () {
                      setState(() {
                        tampilsandipasswordbaru1 = !tampilsandipasswordbaru1;
                      });
                    }),
                const SizedBox(height: 15),
                Roweliminatenumber(
                    isPasswordEightCharacters: isPasswordEightCharacters),
                const SizedBox(height: 10),
                Roweliminatelowup(hasLowerUpper: hasLowerUpper),
                const SizedBox(height: 10),
                Roweliminateonenum(hasPasswordOneNumber: hasPasswordOneNumber),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Obx(
                    () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: accountsController.isLoading.value == true
                            ? null
                            : () async {
                                if (passwordbaru1.text.isNotEmpty) {
                                  if (await accountsController.changePassword(
                                          guruID: accountsController
                                              .guruModels.value?.data.guruId,
                                          newPassword: passwordbaru1.text) ==
                                      true) {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      Navigator.pop(context);
                                    });
                                  }
                                } else {
                                  Get.snackbar("Gagal",
                                      "Password baru tidak boleh kosong.",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                }
                              },
                        child: Text(
                          accountsController.isLoading.value == true
                              ? "Loading..."
                              : "Simpan Perubahan",
                          style: kDefaultTextStyle(fontSize: 17),
                        )),
                  ),
                ),
              ],
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

class Roweliminateonenum extends StatelessWidget {
  const Roweliminateonenum({
    super.key,
    required this.hasPasswordOneNumber,
  });

  final bool hasPasswordOneNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: hasPasswordOneNumber ? Colors.green : Colors.transparent,
              border: hasPasswordOneNumber
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Minimal terdapat 1 angka",
          style: kDefaultTextStyle(fontSize: 14),
        )
      ],
    );
  }
}

class Roweliminatelowup extends StatelessWidget {
  const Roweliminatelowup({
    super.key,
    required this.hasLowerUpper,
  });

  final bool hasLowerUpper;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: hasLowerUpper ? Colors.green : Colors.transparent,
              border: hasLowerUpper
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Huruf kecil dan besar",
          style: kDefaultTextStyle(fontSize: 14),
        )
      ],
    );
  }
}

class Roweliminatenumber extends StatelessWidget {
  const Roweliminatenumber({
    super.key,
    required this.isPasswordEightCharacters,
  });

  final bool isPasswordEightCharacters;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color:
                  isPasswordEightCharacters ? Colors.green : Colors.transparent,
              border: isPasswordEightCharacters
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Panjang minimal 8 karakter",
          style: kDefaultTextStyle(fontSize: 14),
        )
      ],
    );
  }
}
