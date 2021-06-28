class Kaki {
  String variant;
  String kanan;
  String kiri;

  Kaki({this.variant, this.kanan, this.kiri});

  Kaki.fromJson(Map<String, dynamic> json) {
    variant = json['variant'];
    kanan = json['kanan'];
    kiri = json['kiri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant'] = this.variant;
    data['kanan'] = this.kanan;
    data['kiri'] = this.kiri;
    return data;
  }
}
