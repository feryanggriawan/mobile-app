class DeliveryAddress {
  int code;
  bool success;
  String msg;
  String name;
  String phone;
  String provinceId;
  String provinceName;
  String cityId;
  String cityName;
  String district;
  String subdistrict;
  String postCode;
  String address;

  DeliveryAddress(
      {this.code,
        this.success,
        this.msg,
        this.name,
        this.phone,
        this.provinceId,
        this.provinceName,
        this.cityId,
        this.cityName,
        this.district,
        this.subdistrict,
        this.postCode,
        this.address});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msg = json['msg'];
    name = json['name'];
    phone = json['phone'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    district = json['district'];
    subdistrict = json['subdistrict'];
    postCode = json['post_code'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg'] = this.msg;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['district'] = this.district;
    data['subdistrict'] = this.subdistrict;
    data['post_code'] = this.postCode;
    data['address'] = this.address;
    return data;
  }
}
