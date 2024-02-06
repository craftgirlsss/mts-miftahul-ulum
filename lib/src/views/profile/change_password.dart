import 'package:flutter/material.dart';
import 'package:socio_univ/src/components/custom_textfield.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/helpers/focus.dart';

class GantiPassword extends StatefulWidget {
  const GantiPassword({super.key});

  @override
  State<GantiPassword> createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  final passwordsekarang = TextEditingController();
  final passwordbaru1 = TextEditingController();
  final passwordbaru2 = TextEditingController();
  final textfield = KTextField();
  bool tampilsandipasswordsekarang = true;
  bool tampilsandipasswordbaru1 = true;
  bool tampilsandipasswordbaru2 = true;
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  bool hasLowerUpper = false;

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
    return GestureDetector(
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
            // Texfield untuk passsword sekarang
            textfield.passwordinput(
                obecuretext: tampilsandipasswordsekarang,
                controller: passwordsekarang,
                label: "Password Sekarang",
                setstate: () {
                  setState(() {
                    tampilsandipasswordsekarang = !tampilsandipasswordsekarang;
                  });
                }),

            const SizedBox(height: 20),

            // TextField untuk password baru 1
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

            const SizedBox(height: 10),
            //eliminasi
            // logic.eliminate(context: context, text: passwordbaru1.text),
            Roweliminatenumber(
                isPasswordEightCharacters: isPasswordEightCharacters),

            const SizedBox(height: 10),

            Roweliminatelowup(hasLowerUpper: hasLowerUpper),

            const SizedBox(height: 10),
            Roweliminateonenum(hasPasswordOneNumber: hasPasswordOneNumber),

            const SizedBox(height: 10),
            //Textfield untuk password baru 2
            textfield.passwordinput(
                obecuretext: tampilsandipasswordbaru2,
                controller: passwordbaru2,
                label: "Password Baru",
                setstate: () {
                  setState(() {
                    tampilsandipasswordbaru2 = !tampilsandipasswordbaru2;
                  });
                }),
            Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {},
                    child: Text(
                      "Simpan Perubahan",
                      style: kDefaultTextStyle(fontSize: 17),
                    ))),
          ],
        ),
      ),
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
