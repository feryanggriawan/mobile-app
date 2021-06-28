import 'package:tsi_mobile/models/pasien/kaki.dart';

class Visual {
  Kaki kaki;
  Kaki pundak;

  Visual({this.kaki, this.pundak});

  Visual.fromJson(Map<String, dynamic> json) {
    kaki = json['kaki'] != null ? new Kaki.fromJson(json['kaki']) : null;
    pundak = json['pundak'] != null ? new Kaki.fromJson(json['pundak']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kaki != null) {
      data['kaki'] = this.kaki.toJson();
    }
    if (this.pundak != null) {
      data['pundak'] = this.pundak.toJson();
    }
    return data;
  }
}