import 'package:tsi_mobile/models/pasien/anomali.dart';
import 'package:tsi_mobile/models/pasien/detail.dart';
import 'package:tsi_mobile/models/pasien/pubis.dart';
import 'package:tsi_mobile/models/pasien/visual.dart';

class Release {
  String value;
  String description;
  String schedule;
  List<String> penyakit;
  String keluhan;
  Visual visual;
  Pubis pubis;
  Anomali anomali;
  Detail detail;

  Release(
      {this.value,
        this.description,
        this.schedule,
        this.penyakit,
        this.keluhan,
        this.visual,
        this.pubis,
        this.anomali,
        this.detail});

  Release.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    description = json['description'];
    schedule = json['schedule'];
    penyakit = json['penyakit'].cast<String>();
    keluhan = json['keluhan'];
    visual =
    json['visual'] != null ? new Visual.fromJson(json['visual']) : null;
    pubis = json['pubis'] != null ? new Pubis.fromJson(json['pubis']) : null;
    anomali =
    json['anomali'] != null ? new Anomali.fromJson(json['anomali']) : null;
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['description'] = this.description;
    data['schedule'] = this.schedule;
    data['penyakit'] = this.penyakit;
    data['keluhan'] = this.keluhan;
    if (this.visual != null) {
      data['visual'] = this.visual.toJson();
    }
    if (this.pubis != null) {
      data['pubis'] = this.pubis.toJson();
    }
    if (this.anomali != null) {
      data['anomali'] = this.anomali.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}
