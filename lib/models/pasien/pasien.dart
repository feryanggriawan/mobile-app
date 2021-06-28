import 'package:tsi_mobile/models/pasien/release.dart';

class Pasien {
  int id;
  String name;
  String phone;
  String usia;
  String jenisKelamin;
  String address;
  String location;
  String photo;
  String status;
  String descStatus;
  int countRelease;
  List<Release> release;

  Pasien(
      {this.id,
        this.name,
        this.phone,
        this.usia,
        this.jenisKelamin,
        this.address,
        this.location,
        this.photo,
        this.status,
        this.descStatus,
        this.countRelease,
        this.release});

  Pasien.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    usia = json['usia'];
    jenisKelamin = json['jenis_kelamin'];
    address = json['address'];
    location = json['location'];
    photo = json['photo'];
    status = json['status'];
    descStatus = json['desc_status'];
    countRelease = json['count_release'];
    if (json['release'] != null) {
      release = new List<Release>();
      json['release'].forEach((v) {
        release.add(new Release.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['usia'] = this.usia;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['address'] = this.address;
    data['location'] = this.location;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['desc_status'] = this.descStatus;
    data['count_release'] = this.countRelease;
    if (this.release != null) {
      data['release'] = this.release.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
