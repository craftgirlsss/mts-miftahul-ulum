class DaftarKelasModels {
  DaftarKelasModels({
    required this.success,
    required this.data,
    required this.url,
  });
  late final bool success;
  late final List<Data> data;
  late final String url;

  DaftarKelasModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    url = json['url'];
  }
}

class Data {
  Data({
    this.kelasId,
    this.kelasNama,
    this.siswa,
  });
  String? kelasId;
  String? kelasNama;
  List<Siswa>? siswa;

  Data.fromJson(Map<String, dynamic> json) {
    kelasId = json['kelas_id'];
    kelasNama = json['kelas_nama'];
    siswa = List.from(json['siswa']).map((e) => Siswa.fromJson(e)).toList();
  }
}

class Siswa {
  Siswa({
    this.idAbsen,
    this.absenGuruid,
    this.absenSiswaid,
    this.absenLong,
    this.absenLat,
    this.absenLocation,
    this.absenStatus,
    this.absenDatetime,
    this.absenTimestamp,
    this.kelasId,
    this.kelasNama,
    this.tingkatNama,
    this.siswaNama,
    this.siswaNis,
    this.siswaNisn,
    this.siswaGender,
    this.siswaTgllahir,
    this.siswaAlamat,
  });
  String? idAbsen;
  String? absenGuruid;
  String? absenSiswaid;
  String? absenLong;
  String? absenLat;
  String? absenLocation;
  String? absenStatus;
  String? absenDatetime;
  String? absenTimestamp;
  String? kelasId;
  String? kelasNama;
  String? tingkatNama;
  String? siswaNama;
  String? siswaNis;
  String? siswaNisn;
  String? siswaGender;
  String? siswaTgllahir;
  String? siswaAlamat;

  Siswa.fromJson(Map<String, dynamic> json) {
    idAbsen = json['id_absen'] ?? '';
    absenGuruid = json['absen_guruid'] ?? '';
    absenSiswaid = json['absen_siswaid'] ?? '';
    absenLong = json['absen_long'] ?? '';
    absenLat = json['absen_lat'] ?? '';
    absenLocation = json['absen_location'] ?? '';
    absenStatus = json['absen_status'] ?? '';
    absenDatetime = json['absen_datetime'] ?? '';
    absenTimestamp = json['absen_timestamp'] ?? '';
    kelasId = json['kelas_id'] ?? '';
    kelasNama = json['kelas_nama'] ?? '';
    tingkatNama = json['tingkat_nama'] ?? '';
    siswaNama = json['siswa_nama'] ?? '';
    siswaNis = json['siswa_nis'] ?? '';
    siswaNisn = json['siswa_nisn'] ?? '';
    siswaGender = json['siswa_gender'] ?? '';
    siswaTgllahir = json['siswa_tgllahir'] ?? '';
    siswaAlamat = json['siswa_alamat'] ?? '';
  }
}
