import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String code;
  final String nik;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String tempatLahir;
  final String tanggalLahir;
  final String jenisKelamin;
  final String address;
  final String location;
  final String photoUrl;
  final String ktpUrl;
  final String certificateId;
  final String fotoCertificateUrl;
  final String terapis;
  final String status;

  UserModel(
      {this.id,
      this.name,
      this.nik,
      this.username,
      this.code,
      this.address,
      this.certificateId,
      this.email,
      this.fotoCertificateUrl,
      this.jenisKelamin,
      this.ktpUrl,
      this.location,
      this.phone,
      this.photoUrl,
      this.status,
      this.tanggalLahir,
      this.tempatLahir,
      this.terapis});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        code: json['code'],
        nik: json['nik'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        tempatLahir: json['tempat_lahir'],
        tanggalLahir: json['tanggal_lahir'],
        jenisKelamin: json['jenis_kelamin'],
        address: json['address'],
        location: json['location'],
        photoUrl: json['photo'],
        ktpUrl: json['ktp'],
        certificateId: json['certificate_id'],
        fotoCertificateUrl: json['foto_certificate'],
        terapis: json['terapis'],
        status: json['status'],
      );

  @override
  List<Object> get props => [
        id,
        name,
        username,
        nik,
        code,
        address,
        certificateId,
        email,
        fotoCertificateUrl,
        jenisKelamin,
        ktpUrl,
        location,
        phone,
        photoUrl,
        status,
        tanggalLahir,
        tempatLahir,
        terapis
      ];
}
