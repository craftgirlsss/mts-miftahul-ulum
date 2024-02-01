import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socio_univ/src/components/styles.dart';
import 'package:socio_univ/src/mainpage.dart';
import 'package:socio_univ/src/views/qrpage/ar_scanner.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  // This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah anda yakin mengakhiri sesi absensi?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _showAlertDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Konfirmasi",
            style: kDefaultTextStyle(color: Colors.white, fontSize: 15),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/default-person.png'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(height: 40),
                CupertinoFormSection.insetGrouped(
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  margin: const EdgeInsets.all(0),
                  children: [
                    CupertinoListTile.notched(
                      backgroundColor: Colors.black87,
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: CupertinoColors.systemPurple,
                        ),
                        child: const Icon(
                          CupertinoIcons.person_fill,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      additionalInfo: Text(
                        "Unknown",
                        style: kDefaultTextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                      title: Text(
                        'Name',
                        style: kDefaultTextStyle(
                            fontSize: 15, color: Colors.white),
                      ),
                      // trailing: const CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      backgroundColor: Colors.black87,
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: CupertinoColors.activeOrange,
                        ),
                        child: const Icon(
                          CupertinoIcons.person_crop_rectangle,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      additionalInfo: Text(
                        "Unknown",
                        style: kDefaultTextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                      title: Text(
                        'Jenis Kelamin',
                        style: kDefaultTextStyle(
                            fontSize: 15, color: Colors.white),
                      ),
                      // trailing: const CupertinoListTileChevron(),
                      // onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      backgroundColor: Colors.black87,
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: CupertinoColors.activeGreen,
                        ),
                        child: const Icon(
                          CupertinoIcons.book,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      additionalInfo: Text(
                        "Unknown",
                        style: kDefaultTextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                      title: Text(
                        'Kelas',
                        style: kDefaultTextStyle(
                            fontSize: 15, color: Colors.white),
                      ),
                      // trailing: const CupertinoListTileChevron(),
                      // onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      backgroundColor: Colors.black87,
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: CupertinoColors.activeBlue,
                        ),
                        child: const Icon(
                          CupertinoIcons.arrow_down_doc_fill,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      additionalInfo: Text(
                        "Unknown",
                        style: kDefaultTextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                      title: Text(
                        'Alasan',
                        style: kDefaultTextStyle(
                            fontSize: 15, color: Colors.white),
                      ),
                      // trailing: const CupertinoListTileChevron(),
                      // onTap: () {},
                    ),
                    CupertinoListTile.notched(
                      backgroundColor: Colors.black87,
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: CupertinoColors.activeBlue,
                        ),
                        child: const Icon(
                          CupertinoIcons.number,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      additionalInfo: Text(
                        "Unknown",
                        style: kDefaultTextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                      title: Text(
                        'ID Siswa',
                        style: kDefaultTextStyle(
                            fontSize: 15, color: Colors.white),
                      ),
                      // trailing: const CupertinoListTileChevron(),
                      // onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeBlue),
                      onPressed: () {
                        Get.off(() => const MainPage());
                      },
                      child: Text(
                        "Akhiri Absensi",
                        style: kDefaultTextStyle(
                            color: Colors.white, fontSize: 15),
                      ))),
              const SizedBox(width: 10),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeGreen),
                      onPressed: () {
                        Get.to(() => const QRCodePage());
                      },
                      child: Text(
                        "Lanjutkan Scan",
                        style: kDefaultTextStyle(
                            color: Colors.white, fontSize: 15),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
