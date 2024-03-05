class AbsensiGuruModels {
  AbsensiGuruModels({
    required this.success,
    required this.data,
    required this.url,
    required this.version,
    required this.download,
  });
  late final bool success;
  late final List<Data> data;
  late final String url;
  late final String version;
  late final String download;

  AbsensiGuruModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    url = json['url'];
    version = json['version'];
    download = json['download'];
  }
}

class Data {
  Data({
    this.idAbsgru,
    this.absgruAbsensor,
    this.absgruGuruid,
    this.absgruLong,
    this.absgruLat,
    this.absgruLocation,
    this.absgruStatus,
    this.absgruDatetime,
    this.absgruTimestamp,
    this.guruNama
  });
  String? idAbsgru;
  String? absgruAbsensor;
  String? absgruGuruid;
  String? absgruLong;
  String? absgruLat;
  String? absgruLocation;
  String? absgruStatus;
  String? guruNama;
  String? absgruDatetime;
  String? guruNIP;
  String? absgruTimestamp;

  Data.fromJson(Map<String, dynamic> json) {
    idAbsgru = json['id_absgru'] ?? '';
    absgruAbsensor = json['absgru_absensor'] ?? '';
    absgruGuruid = json['absgru_guruid'] ?? '';
    absgruLong = json['absgru_long'] ?? '';
    absgruLat = json['absgru_lat'] ?? '';
    absgruLocation = json['absgru_location'] ?? '';
    absgruStatus = json['absgru_status'] ?? '';
    absgruDatetime = json['absgru_datetime'] ?? '';
    absgruTimestamp = json['absgru_timestamp'] ?? '';
    guruNama = json['guru_nama'];
    guruNIP = json['guru_nip'];
  }
}
