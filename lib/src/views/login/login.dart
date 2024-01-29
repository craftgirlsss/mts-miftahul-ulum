import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/buttons.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/helpers/focus.dart';
import 'package:socio_univ/src/mainpage.dart';

class ViewLogin extends StatefulWidget {
  const ViewLogin({super.key});

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
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
      controller: emailController,
      keyboardType: TextInputType.number,
      autofocus: false,
      style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white54,
          hintText: 'NIP',
          hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(32.0),
          )),
    );

    final passwordField = Obx(
      () => TextFormField(
        controller: passController,
        autofocus: false,
        obscureText: obsecure.value,
        style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
        decoration: InputDecoration(
          fillColor: Colors.white54,
          filled: true,
          hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          hintText: 'Kata Sandi',
          suffixIconColor: Colors.black54,
          suffixIcon: GestureDetector(
            onTap: () {
              obsecure.value = !obsecure.value;
            },
            child: obsecure.value
                ? const Icon(
                    Icons.visibility,
                    color: Colors.black38,
                  )
                : const Icon(
                    Icons.visibility_off_rounded,
                    color: Colors.black38,
                  ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                32.0,
              )),
        ),
      ),
    );

    return GestureDetector(
      onTap: () => focusManager(),
      child: Scaffold(
          backgroundColor: Colors.green.shade600,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            logo,
                            const SizedBox(height: 30),
                            emailField,
                            const SizedBox(height: 10.0),
                            passwordField,
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Get.to(() => const ForgotPassword());
                                  },
                                  child: Text(
                                    'Lupa Kata Sandi?',
                                    style:
                                        kDefaultTextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            kDefaultButtons(
                                backgroundColor: Colors.blue.shade800,
                                onPressed: () {
                                  Get.to(() => const MainPage());
                                },
                                title: "Masuk"),
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
