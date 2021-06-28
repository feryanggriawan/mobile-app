import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final int id;
  final String code;
  final String cityName;
  final String citySlug;
  final String provinceId;
  final String provinceName;
  final String district;
  final String subdistrict;
  final String postCode;
  final String address;

  LocationModel(
      {this.id,
      this.code,
      this.cityName,
      this.citySlug,
      this.provinceId,
      this.provinceName,
      this.address,
      this.district,
      this.subdistrict,
      this.postCode});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      id: json['id'],
      code: json['code'],
      cityName: json['city_name'],
      citySlug: json['city_slug'],
      provinceName: json['province_name'],
      provinceId: json['province_id'],
      district: json['district'],
      subdistrict: json['subdistrict'],
      postCode: json['post_code'],
      address: json['address']);

  @override
  List<Object> get props => [
        id,
        code,
        cityName,
        citySlug,
        provinceId,
        provinceName,
        address,
        district,
        subdistrict,
        postCode
      ];
}
