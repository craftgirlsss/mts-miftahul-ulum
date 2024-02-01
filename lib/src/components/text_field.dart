import 'package:flutter/material.dart';
import 'package:socio_univ/src/components/styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? iconData;
  const CustomTextField(
      {super.key, this.controller, this.hintText, this.iconData});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white30,
          prefixIcon: Icon(
            widget.iconData,
            color: Colors.white,
          ),
          hintText: widget.hintText,
          hintStyle: kDefaultTextStyle(color: Colors.white, fontSize: 15),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(32.0),
          )),
    );
  }
}
