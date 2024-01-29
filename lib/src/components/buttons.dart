import 'package:flutter/material.dart';
import 'package:socio_univ/src/components/styles.dart';

ElevatedButton kDefaultButtons({
  String? title,
  Function()? onPressed,
  Color? backgroundColor = Colors.blue,
  Color? textColor = Colors.white,
}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.all(0),
          backgroundColor: backgroundColor),
      child: Text(title ?? 'Title',
          style: kDefaultTextStyleBold(color: textColor, fontSize: 17)));
}

ElevatedButton kDefaultButtonWithIcons({
  String? title,
  Function()? onPressed,
  String? urlImage,
  Color? backgroundColor = Colors.blue,
  Color? textColor = Colors.white,
}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.all(0),
          backgroundColor: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(urlImage!),
          const SizedBox(width: 8),
          Text(title ?? 'Title',
              style: kDefaultTextStyleBold(color: textColor, fontSize: 15)),
        ],
      ));
}
