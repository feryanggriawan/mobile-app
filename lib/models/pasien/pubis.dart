import 'package:tsi_mobile/models/pasien/data1.dart';
import 'package:tsi_mobile/models/pasien/data2.dart';

class Pubis {
  Data1 data1;
  List<Data2> data2;

  Pubis({this.data1, this.data2});

  Pubis.fromJson(Map<String, dynamic> json) {
    data1 = json['data1'] != null ? new Data1.fromJson(json['data1']) : null;
    if (json['data2'] != null) {
      data2 = new List<Data2>();
      json['data2'].forEach((v) {
        data2.add(new Data2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data1 != null) {
      data['data1'] = this.data1.toJson();
    }
    if (this.data2 != null) {
      data['data2'] = this.data2.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
