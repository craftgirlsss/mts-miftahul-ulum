import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.defaultDialog(
          title: 'Keluar',
          content: Text('Apakah anda ')
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Konfirmasi"),
          automaticallyImplyLeading: false,
        ),
      ),
    );
  }
}