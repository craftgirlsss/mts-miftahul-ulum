import 'package:flutter/material.dart';

// Untuk keyboard agar tidak overflow screen
void focusManager() {
  FocusManager.instance.primaryFocus?.unfocus();
}
