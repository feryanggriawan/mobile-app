class Kanan {
  String depan;
  String samping;
  String hasilDepanSamping;
  String atas;
  String bawah;
  String hasilAtasBawah;

  Kanan(
      {this.depan,
        this.samping,
        this.hasilDepanSamping,
        this.atas,
        this.bawah,
        this.hasilAtasBawah});

  Kanan.fromJson(Map<String, dynamic> json) {
    depan = json['depan'];
    samping = json['samping'];
    hasilDepanSamping = json['hasil_depan_samping'];
    atas = json['atas'];
    bawah = json['bawah'];
    hasilAtasBawah = json['hasil_atas_bawah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['depan'] = this.depan;
    data['samping'] = this.samping;
    data['hasil_depan_samping'] = this.hasilDepanSamping;
    data['atas'] = this.atas;
    data['bawah'] = this.bawah;
    data['hasil_atas_bawah'] = this.hasilAtasBawah;
    return data;
  }
}