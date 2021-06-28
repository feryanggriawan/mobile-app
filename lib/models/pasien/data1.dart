import 'package:tsi_mobile/models/pasien/kanan.dart';

class Data1 {
  Kanan kanan;
  Kanan kiri;

  Data1({this.kanan, this.kiri});

  Data1.fromJson(Map<String, dynamic> json) {
    kanan = json['kanan'] != null ? new Kanan.fromJson(json['kanan']) : null;
    kiri = json['kiri'] != null ? new Kanan.fromJson(json['kiri']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kanan != null) {
      data['kanan'] = this.kanan.toJson();
    }
    if (this.kiri != null) {
      data['kiri'] = this.kiri.toJson();
    }
    return data;
  }
}