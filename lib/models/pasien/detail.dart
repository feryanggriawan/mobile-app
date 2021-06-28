import 'package:tsi_mobile/models/pasien/kaki_kanan.dart';

class Detail {
  KakiKanan kakiKanan;
  KakiKanan kakiKiri;

  Detail({this.kakiKanan, this.kakiKiri});

  Detail.fromJson(Map<String, dynamic> json) {
    kakiKanan = json['kaki_kanan'] != null
        ? new KakiKanan.fromJson(json['kaki_kanan'])
        : null;
    kakiKiri = json['kaki_kiri'] != null
        ? new KakiKanan.fromJson(json['kaki_kiri'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kakiKanan != null) {
      data['kaki_kanan'] = this.kakiKanan.toJson();
    }
    if (this.kakiKiri != null) {
      data['kaki_kiri'] = this.kakiKiri.toJson();
    }
    return data;
  }
}
