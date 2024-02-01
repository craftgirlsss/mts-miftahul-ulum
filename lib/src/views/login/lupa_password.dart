import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/buttons.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/helpers/focus.dart';
import 'package:socio_univ/src/mainpage.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
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

    return GestureDetector(
      onTap: () => focusManager(),
      child: Scaffold(
          backgroundColor: Colors.green.shade600,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.green.shade600,
            title: Text(
              "Lupa Password",
              style: kDefaultTextStyleBold(color: Colors.white, fontSize: 23),
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
                            // Text(
                            //   "Masuk",
                            //   style: kDefaultTextStyleBold(fontSize: 27),
                            // ),
                            const SizedBox(height: 10),
                            emailField,
                            // const SizedBox(height: 10.0),
                            // passwordField,
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Ingat Sandi? Masuk',
                                    style:
                                        kDefaultTextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            kDefaultButtons(
                                backgroundColor: Colors.black87,
                                onPressed: () {
                                  Get.to(() => const MainPage());
                                },
                                title: "Kirim Kode Verifikasi"),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
