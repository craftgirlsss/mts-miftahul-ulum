class SiswaModels {
  SiswaModels({
    required this.success,
    required this.data,
    required this.url,
  });
  late final bool success;
  late final Data data;
  late final String url;

  SiswaModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    url = json['url'];
  }
}

class Data {
  Data({
    this.siswaId,
    this.siswaNis,
    this.siswaNisn,
    this.siswaNama,
    this.tingkatId,
    this.kelasId,
    this.siswaGender,
    this.siswaTempat,
    this.siswaTgllahir,
    this.password,
    this.lembagaId,
    this.iEntry,
    this.dEntry,
    this.iUpdate,
    this.dUpdate,
    this.siswaFoto,
    this.siswaFolder,
    this.siswaAgama,
    this.siswaPendidikan,
    this.siswaAlamat,
    this.namaAyah,
    this.namaIbu,
    this.pekerjaanAyah,
    this.pekerjaanIbu,
    this.nikAyah,
    this.nikIbu,
    this.alamatOrtu,
    this.desaId,
    this.kecamatanId,
    this.kabupatenId,
    this.provinsiId,
    this.namaWali,
    this.pekerjaanWali,
    this.alamatWali,
    this.tahunajaranId,
    this.migrasi,
    this.siswaStatuskel,
    this.siswaAnakke,
    this.sekolahAsal,
    this.siswaTelpon,
    this.telponOrtu,
    this.telponWali,
    this.tanggalTerima,
    this.siswaKelasterima,
    this.siswaAlasanMutasi,
    this.siswaTahunMutasi,
    this.siswaSemesterMutasi,
    this.siswaEmis,
  });
  String? siswaId;
  String? siswaNis;
  String? siswaNisn;
  String? siswaNama;
  String? tingkatId;
  String? kelasId;
  String? siswaGender;
  String? siswaTempat;
  String? siswaTgllahir;
  String? password;
  String? lembagaId;
  String? iEntry;
  String? dEntry;
  String? iUpdate;
  String? dUpdate;
  String? siswaFoto;
  String? siswaFolder;
  String? siswaAgama;
  String? siswaPendidikan;
  String? siswaAlamat;
  String? namaAyah;
  String? namaIbu;
  String? pekerjaanAyah;
  String? pekerjaanIbu;
  String? nikAyah;
  String? nikIbu;
  String? alamatOrtu;
  String? desaId;
  String? kecamatanId;
  String? kabupatenId;
  String? provinsiId;
  String? namaWali;
  String? pekerjaanWali;
  String? alamatWali;
  String? tahunajaranId;
  String? migrasi;
  String? siswaStatuskel;
  String? siswaAnakke;
  String? sekolahAsal;
  String? siswaTelpon;
  String? telponOrtu;
  String? telponWali;
  String? tanggalTerima;
  String? siswaKelasterima;
  String? siswaAlasanMutasi;
  String? siswaTahunMutasi;
  String? siswaSemesterMutasi;
  String? siswaEmis;

  Data.fromJson(Map<String, dynamic> json) {
    siswaId = json['siswa_id'] ?? '';
    siswaNis = json['siswa_nis'] ?? '';
    siswaNisn = json['siswa_nisn'] ?? '';
    siswaNama = json['siswa_nama'] ?? '';
    tingkatId = json['tingkat_id'] ?? '';
    kelasId = json['kelas_id'] ?? '';
    siswaGender = json['siswa_gender'] ?? '';
    siswaTempat = json['siswa_tempat'] ?? '';
    siswaTgllahir = json['siswa_tgllahir'] ?? '';
    password = json['password'] ?? '';
    lembagaId = json['lembaga_id'] ?? '';
    iEntry = json['-_entry'] ?? '';
    dEntry = json['d_enrty'] ?? '';
    iUpdate = json['i_update'] ?? '';
    dUpdate = json['d_update'] ?? '';
    siswaFoto = json['siswa_foto'] ?? '';
    siswaFolder = json['sisw_folder'] ?? '';
    siswaAgama = json['siswa_agama'] ?? '';
    siswaPendidikan = json['siswa_pendidikan'] ?? '';
    siswaAlamat = json['siswa_alamat'] ?? '';
    namaAyah = json['nama_ayah'] ?? '';
    namaIbu = json['nama_ibu'] ?? '';
    pekerjaanAyah = json['pekerjaan_ayah'] ?? '';
    pekerjaanIbu = json['pekerjaan_ibu'] ?? '';
    nikAyah = json['nik_ayah'] ?? '';
    nikIbu = json['nik_ibu'] ?? '';
    alamatOrtu = json['alamat_ortu'] ?? '';
    desaId = json['dasa_id'] ?? '';
    kecamatanId = json['kecamatan_id'] ?? '';
    kabupatenId = json['kabupaten_id'] ?? '';
    provinsiId = json['provinsi_id'] ?? '';
    namaWali = json['nama_wali'] ?? '';
    pekerjaanWali = json['pekerjaan_wali'] ?? '';
    alamatWali = json['alamat_wali'] ?? '';
    tahunajaranId = json['tahunajaran_id'] ?? '';
    migrasi = json['migrasi'] ?? '';
    siswaStatuskel = json['siswa_statuskel'] ?? '';
    siswaAnakke = json['siswa_anakke'] ?? '';
    sekolahAsal = json['sekolah_asal'] ?? '';
    siswaTelpon = json['siswa_telpon'] ?? '';
    telponOrtu = json['telpon_ortu'] ?? '';
    telponWali = json['telpon_wali'] ?? '';
    tanggalTerima = json['tanggal_terima'] ?? '';
    siswaKelasterima = json['siswa_kelasterima'] ?? '';
    siswaAlasanMutasi = json['siswa_alasan_mutasi'] ?? '';
    siswaTahunMutasi = json['siswa_tahun_mutasi'] ?? '';
    siswaSemesterMutasi = json['siswa_semester_mutasi'] ?? '';
    siswaEmis = json['siswa_emis'] ?? '';
  }
}
