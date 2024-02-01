import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socio_univ/src/components/styles.dart';

class DetailSiswa extends StatefulWidget {
  final String? namaSiswa;
  final String? jamHadir;
  final String? kelas;
  final String? siswaID;
  final String? jenisKelamin;
  const DetailSiswa(
      {super.key,
      this.namaSiswa,
      this.jamHadir,
      this.kelas,
      this.siswaID,
      this.jenisKelamin});

  @override
  State<DetailSiswa> createState() => _DetailSiswaState();
}

class _DetailSiswaState extends State<DetailSiswa> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Informasi Siswa",
          style: kDefaultTextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      widget.namaSiswa ?? "Unknown",
                      style: kDefaultTextStyle(
                          color: Colors.white38, fontSize: 12),
                    ),
                    title: Text(
                      'Name',
                      style:
                          kDefaultTextStyle(fontSize: 15, color: Colors.white),
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
                      widget.jenisKelamin ?? "Unknown",
                      style: kDefaultTextStyle(
                          color: Colors.white38, fontSize: 12),
                    ),
                    title: Text(
                      'Jenis Kelamin',
                      style:
                          kDefaultTextStyle(fontSize: 15, color: Colors.white),
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
                        color: CupertinoColors.activeGreen,
                      ),
                      child: const Icon(
                        CupertinoIcons.book,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    additionalInfo: Text(
                      widget.kelas ?? "Unknown",
                      style: kDefaultTextStyle(
                          color: Colors.white38, fontSize: 12),
                    ),
                    title: Text(
                      'Kelas',
                      style:
                          kDefaultTextStyle(fontSize: 15, color: Colors.white),
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
                        color: CupertinoColors.activeBlue,
                      ),
                      child: const Icon(
                        CupertinoIcons.clock,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    additionalInfo: Text(
                      widget.jamHadir ?? "Unknown",
                      style: kDefaultTextStyle(
                          color: Colors.white38, fontSize: 12),
                    ),
                    title: Text(
                      'Jam Masuk',
                      style:
                          kDefaultTextStyle(fontSize: 15, color: Colors.white),
                    ),
                    // trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
