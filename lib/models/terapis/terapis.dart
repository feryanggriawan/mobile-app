import 'package:tsi_mobile/models/terapis/member.dart';

class Terapis {
  int id;
  String type;
  String name;
  String phone;
  String address;
  String location;
  String photo;
  List<String> accept;
  List<String> noAccept;
  String countPasien;
  String status;
  Member member;

  Terapis(
      {this.id,
      this.type,
      this.name,
      this.phone,
      this.address,
      this.location,
      this.photo,
      this.accept,
      this.noAccept,
      this.countPasien,
      this.status,
      this.member});

  Terapis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    location = json['location'];
    photo = json['photo'];
    accept = json["accept"] is String ? null : json['accept'].cast<String>();
    noAccept =
        json["no_accept"] is String ? null : json['no_accept'].cast<String>();
    countPasien = (json["count_pasien"] is int)
        ? json['count_pasien'].toString()
        : json['count_pasien'];
    status = json['status'];
    member =
        json['member'] != null ? new Member.fromJson(json['member']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['location'] = this.location;
    data['photo'] = this.photo;
    data['accept'] = this.accept;
    data['no_accept'] = this.noAccept;
    data['count_pasien'] = this.countPasien;
    data['status'] = this.status;
    if (this.member != null) {
      data['member'] = this.member.toJson();
    }
    return data;
  }
}
