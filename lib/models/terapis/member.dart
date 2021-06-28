

class Member {
  int id;
  String code;
  String nik;
  String name;
  String username;
  String email;
  String phone;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String address;
  String location;
  String photo;
  String ktp;
  String certificateId;
  String fotoCertificate;
  String terapis;
  String status;

  Member(
      {this.id,
        this.code,
        this.nik,
        this.name,
        this.username,
        this.email,
        this.phone,
        this.tempatLahir,
        this.tanggalLahir,
        this.jenisKelamin,
        this.address,
        this.location,
        this.photo,
        this.ktp,
        this.certificateId,
        this.fotoCertificate,
        this.terapis,
        this.status});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nik = json['nik'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    jenisKelamin = json['jenis_kelamin'];
    address = json['address'];
    location = json['location'];
    photo = json['photo'];
    ktp = json['ktp'];
    certificateId = json['certificate_id'];
    fotoCertificate = json['foto_certificate'];
    terapis = json['terapis'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['nik'] = this.nik;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['tempat_lahir'] = this.tempatLahir;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['address'] = this.address;
    data['location'] = this.location;
    data['photo'] = this.photo;
    data['ktp'] = this.ktp;
    data['certificate_id'] = this.certificateId;
    data['foto_certificate'] = this.fotoCertificate;
    data['terapis'] = this.terapis;
    data['status'] = this.status;
    return data;
  }
}