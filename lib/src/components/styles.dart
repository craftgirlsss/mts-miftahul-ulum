import 'package:flutter/material.dart';

// Font size defualt using Poppins regular
kDefaultTextStyle(
    {double? fontSize = 13,
    FontWeight? fontWeight = FontWeight.normal,
    Color? color = Colors.white}) {
  return TextStyle(
      fontFamily: 'Poppins-Regular',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight);
}

// Font size defualt using Poppins Italic
kDefaultTextStyleItalic(
    {double? fontSize = 13,
    FontWeight? fontWeight = FontWeight.normal,
    Color? color = Colors.white}) {
  return TextStyle(
      fontFamily: 'Poppins-Italic',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight);
}

// Font size defualt using Poppins Bold
kDefaultTextStyleBold({double? fontSize = 13, Color? color = Colors.white}) {
  return TextStyle(
      fontFamily: 'Poppins-Bold', fontSize: fontSize, color: color);
}
