import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/buttons.dart';
import 'package:socio_univ/src/components/loadings.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/controllers/account_controller.dart';
import 'package:socio_univ/src/helpers/focus.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  AccountsController accountsController = Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _keyFormLogin = GlobalKey<FormState>();
  var obsecure = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 60.0,
      child: Hero(tag: 'logo', child: Image.asset('assets/icons/logo.png')),
    );

    final emailField = TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email,
          color: Colors.black54,
        ),
        filled: true,
        fillColor: Colors.white54,
        hintText: 'Email',
        hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onChanged: (text) {
        assert(EmailValidator.validate(text));
      },
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
              backgroundColor: Colors.green.shade600,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.green.shade600,
                title: Text(
                  "Lupa Password",
                  style:
                      kDefaultTextStyleBold(color: Colors.white, fontSize: 23),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        child: Form(
                          key: _keyFormLogin,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                logo,
                                const SizedBox(height: 10),
                                Hero(
                                  tag: "sekolah",
                                  child: DefaultTextStyle(
                                    style: kDefaultTextStyleBold(fontSize: 20),
                                    child: const Text(
                                      "Aplikasi Absensi Siswa\nMTs Miftahul Ulum\nSampang",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const SizedBox(height: 10),
                                emailField,
                                const SizedBox(height: 20),
                                Obx(
                                  () => kDefaultButtons(
                                      backgroundColor: Colors.black87,
                                      onPressed: accountsController
                                                  .isLoading.value ==
                                              true
                                          ? () {}
                                          : () async {
                                              if (await accountsController
                                                      .forgotPassword() ==
                                                  true) {
                                                Future.delayed(
                                                    const Duration(seconds: 3),
                                                    () {
                                                  Get.back();
                                                });
                                              }
                                            },
                                      title:
                                          accountsController.isLoading.value ==
                                                  true
                                              ? 'Mengirim Email...'
                                              : "Kirim Kode Verifikasi"),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              )),
        ),
        Obx(() => accountsController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}
