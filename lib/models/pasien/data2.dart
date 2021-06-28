class Data2 {
  String bagian;
  String value;
  String sebelah;

  Data2({this.bagian, this.value, this.sebelah});

  Data2.fromJson(Map<String, dynamic> json) {
    bagian = json['bagian'];
    value = json['value'];
    sebelah = json['sebelah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bagian'] = this.bagian;
    data['value'] = this.value;
    data['sebelah'] = this.sebelah;
    return data;
  }
}
