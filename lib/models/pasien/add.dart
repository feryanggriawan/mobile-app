class AddPasien {
  int code;
  bool success;
  int type;
  String descType;
  int terapiId;
  int pasienId;
  String msg;

  AddPasien(
      {this.code,
        this.success,
        this.type,
        this.descType,
        this.terapiId,
        this.pasienId,
        this.msg});

  AddPasien.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    type = json['type'];
    descType = json['desc_type'];
    terapiId = json['terapi_id'];
    pasienId = json['pasien_id'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['type'] = this.type;
    data['desc_type'] = this.descType;
    data['terapi_id'] = this.terapiId;
    data['pasien_id'] = this.pasienId;
    data['msg'] = this.msg;
    return data;
  }
}
