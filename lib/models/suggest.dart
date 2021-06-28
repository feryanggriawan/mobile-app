import 'package:tsi_mobile/models/models.dart';

class Suggest {
  int code;
  bool success;
  int id;
  String title;
  Visual visual;
  Pubis pubis;
  Anomali anomali;
  Detail detail;
  Visualisasi visualisasi;

  Suggest(
      {this.code,
        this.success,
        this.id,
        this.title,
        this.visual,
        this.pubis,
        this.anomali,
        this.detail,
        this.visualisasi});

  Suggest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    id = json['id'];
    title = json['title'];
    visual =
    json['visual'] != null ? new Visual.fromJson(json['visual']) : null;
    pubis = json['pubis'] != null ? new Pubis.fromJson(json['pubis']) : null;
    anomali =
    json['anomali'] != null ? new Anomali.fromJson(json['anomali']) : null;
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    visualisasi = json['visualisasi'] != null
        ? new Visualisasi.fromJson(json['visualisasi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['id'] = this.id;
    data['title'] = this.title;
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
    if (this.visualisasi != null) {
      data['visualisasi'] = this.visualisasi.toJson();
    }
    return data;
  }
}


class Visualisasi {
  Penyimpangan penyimpangan;
  Penyimpangan solusi;

  Visualisasi({this.penyimpangan, this.solusi});

  Visualisasi.fromJson(Map<String, dynamic> json) {
    penyimpangan = json['penyimpangan'] != null
        ? new Penyimpangan.fromJson(json['penyimpangan'])
        : null;
    solusi = json['solusi'] != null
        ? new Penyimpangan.fromJson(json['solusi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.penyimpangan != null) {
      data['penyimpangan'] = this.penyimpangan.toJson();
    }
    if (this.solusi != null) {
      data['solusi'] = this.solusi.toJson();
    }
    return data;
  }
}

class Penyimpangan {
  String jenis;
  String variant;
  String sebelah;
  int countImage;
  int countVideo;

  Penyimpangan(
      {this.jenis,
        this.variant,
        this.sebelah,
        this.countImage,
        this.countVideo});

  Penyimpangan.fromJson(Map<String, dynamic> json) {
    jenis = json['jenis'];
    variant = json['variant'];
    sebelah = json['sebelah'];
    countImage = json['count_image'];
    countVideo = json['count_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jenis'] = this.jenis;
    data['variant'] = this.variant;
    data['sebelah'] = this.sebelah;
    data['count_image'] = this.countImage;
    data['count_video'] = this.countVideo;
    return data;
  }
}