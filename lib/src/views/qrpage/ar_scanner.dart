// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:get/get.dart';
// import 'package:socio_univ/src/components/loadings.dart';
// import 'package:socio_univ/src/controllers/siswa_controller.dart';

// import 'confirmation_absence.dart';

// class QRCodePage extends StatefulWidget {
//   const QRCodePage({super.key});

//   @override
//   State<QRCodePage> createState() => _QRCodePageState();
// }

// class _QRCodePageState extends State<QRCodePage> {
//   SiswaController siswaController = Get.find();
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   // Barcode? result;
//   // QRViewController? controller;

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   // @override
//   // void reassemble() {
//   //   super.reassemble();
//   //   if (Platform.isAndroid) {
//   //     controller!.pauseCamera();
//   //   } else if (Platform.isIOS) {
//   //     controller!.resumeCamera();
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     return Stack(
//       children: [
//         Scaffold(
//           body: scanQR(context)
//           // QRView(
//           //   key: qrKey,
//           //   onQRViewCreated: _onQRViewCreated,
//           //   overlay: QrScannerOverlayShape(
//           //       borderColor: Colors.red,
//           //       borderRadius: 10,
//           //       borderLength: 30,
//           //       borderWidth: 10,
//           //       cutOutSize: scanArea),
//           //   onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//           // ),
//         ),
//         Obx(() => siswaController.isLoading.value == true
//             ? floatingLoading()
//             : const SizedBox()),
//       ],
//     );
//   }

//   // void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//   //   // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//   //   if (!p) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('no Permission')),
//   //     );
//   //   }
//   // }

//   // void _onQRViewCreated(QRViewController controller) {
//   //   this.controller = controller;
//   //   controller.scannedDataStream.listen((scanData) async {
//   //     debugPrint(scanData.code);
//   //     Get.to(() => ConfirmationPage(nis: scanData.code!));
//   //     // setState(() {

//   //     //   result = scanData;
//   //     // });
//   //   });
//   // }

//   @override
//   void dispose() {
//     // controller?.dispose();
//     super.dispose();
//   }

//   Future<void> scanQR(context) async {
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }

//     if (!mounted) return;

//     Get.to(
//       () => ConfirmationPage(nis: barcodeScanRes)

//       // WebViewPage(
//       //   urls: ("$barcodeScanRes&apps=true"),
//       // ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/views/qrpage/confirmation_absence.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({super.key});

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  Future<void> scanQR(context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    Get.to(() => ConfirmationPage(nis: barcodeScanRes));
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.QR)!
        .listen((barcode) {
      Get.to(() => ConfirmationPage(nis: barcode));
    });
  }

  @override
  Widget build(BuildContext context) {
    scanQR(context);
    return const Scaffold(
      backgroundColor: Colors.transparent,
    );
  }
}
