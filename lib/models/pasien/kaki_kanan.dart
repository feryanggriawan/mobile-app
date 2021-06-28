class KakiKanan {
  String depanSamping;
  String atasBawah;

  KakiKanan({this.depanSamping, this.atasBawah});

  KakiKanan.fromJson(Map<String, dynamic> json) {
    depanSamping = json['depan_samping'];
    atasBawah = json['atas_bawah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['depan_samping'] = this.depanSamping;
    data['atas_bawah'] = this.atasBawah;
    return data;
  }
}
