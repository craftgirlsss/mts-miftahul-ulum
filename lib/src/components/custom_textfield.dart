import 'package:flutter/material.dart';
import 'package:socio_univ/src/components/styles.dart';

class KTextField {
  //User input untuk username
  TextFormField kUsernameField({required TextEditingController controller}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon isikan Email anda';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      controller: controller, //controller email
      decoration: InputDecoration(
        label: const Text("Email"),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  //text input untuk personal data
  TextFormField personaldata(
      {required TextEditingController controllers, required String? label}) {
    return TextFormField(
      readOnly: true,
      enabled: false,
      decoration: InputDecoration(
        label: Text('$label'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      controller: controllers,
    );
  }

  //Text Input untuk Password input
  TextFormField passwordinput({
    required bool obecuretext,
    required TextEditingController controller,
    required String label,
    required void Function()? setstate,
    void Function(String text)? onchanged,
  }) {
    return TextFormField(
      style: kDefaultTextStyle(color: Colors.white, fontSize: 15),
      autofillHints: const [AutofillHints.password],
      obscureText: obecuretext,
      onChanged: onchanged,
      cursorColor: Colors.white,
      obscuringCharacter: '*',
      textInputAction: TextInputAction.next,
      validator: (e) {
        if (e!.isEmpty) {
          return "Harap Masukkan Password";
        }
        return null;
      },
      controller: controller, //controller password
      decoration: InputDecoration(
          hintStyle: kDefaultTextStyle(color: Colors.white, fontSize: 15),
          // label: Text(label),
          hintText: label,
          filled: true,
          fillColor: Colors.white30,
          suffixIcon: GestureDetector(
            onTap: setstate,
            child: obecuretext
                ? const Icon(
                    Icons.visibility,
                    color: Colors.white60,
                  )
                : const Icon(
                    Icons.visibility_off_rounded,
                    color: Colors.white60,
                  ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(32.0),
          )),
    );
  }
}
