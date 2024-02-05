import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:socio_univ/src/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade500,
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/icons/logo.png',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "MTs Miftahul Ulum\nPasean Pamekasan",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
