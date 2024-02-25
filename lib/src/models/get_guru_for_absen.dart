class GuruModelsForAbsence {
  GuruModelsForAbsence({
    required this.success,
    required this.data,
    required this.url,
  });
  late final bool success;
  late final Data data;
  late final String url;

  GuruModelsForAbsence.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    url = json['url'];
  }
}

class Data {
  Data({
    this.guruId,
    this.guruNama,
    this.guruGender,
    this.guruPendidikan,
    this.guruTempat,
    this.guruTgllahir,
    this.guruNuptk,
    this.guruNip,
    this.password,
    this.passwordNew,
    this.lembagaId,
    this.iEntry,
    this.dEntry,
    this.guruEmail,
    this.iUpdate,
    this.dUpdate,
    this.guruFoto,
    this.guruFolder,
    this.guruStatus,
    this.migrasi,
    this.guruAktif,
  });
  String? guruId;
  String? guruNama;
  String? guruGender;
  String? guruPendidikan;
  String? guruTempat;
  String? guruTgllahir;
  String? guruNuptk;
  String? guruEmail;
  String? guruNip;
  String? password;
  String? passwordNew;
  String? lembagaId;
  String? iEntry;
  String? dEntry;
  String? iUpdate;
  String? dUpdate;
  String? guruFoto;
  String? guruFolder;
  String? guruStatus;
  String? migrasi;
  String? guruAktif;

  Data.fromJson(Map<String, dynamic> json) {
    guruId = json['guru_id'] ?? '';
    guruNama = json['guru_nama'] ?? '';
    guruGender = json['guru_gender'] ?? '';
    guruPendidikan = json['guru_pendidikan'] ?? '';
    guruTempat = json['guru_tempat'] ?? '';
    guruTgllahir = json['guru_tgllahir'] ?? '';
    guruNuptk = json['guru_nuptk'] ?? '';
    guruNip = json['guru_nip'] ?? '';
    password = json['password'] ?? '';
    passwordNew = json['password_new'] ?? '';
    lembagaId = json['lembaga_id'] ?? '';
    iEntry = json['i_entry'] ?? '';
    dEntry = json['d_entry'] ?? '';
    guruEmail = json['guru_email'] ?? 'Belum diset';
    iUpdate = json['i_update'] ?? '';
    dUpdate = json['i_update'] ?? '';
    guruFoto = json['guru_foto'] ?? '';
    guruFolder = json['guru_folder'] ?? '';
    guruStatus = json['guru_status'] ?? '';
    migrasi = json['migrasi'] ?? '';
    guruAktif = json['guru_aktif'] ?? '';
  }
}
