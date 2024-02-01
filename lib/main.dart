import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/views/splash/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        title: 'MTs Miftahul Ulum',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white)),
          iconTheme: const IconThemeData(
            color: Colors.white60,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
