class Carrier {
  int id;
  String name;
  String slug;
  String code;
  String terms;
  String serviceDisplay;
  String serviceCharge;
  String etd;
  String image;
  String by;

  Carrier(
      {this.id,
        this.name,
        this.slug,
        this.code,
        this.terms,
        this.serviceDisplay,
        this.serviceCharge,
        this.etd,
        this.image,
        this.by});

  Carrier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    code = json['code'];
    terms = json['terms'];
    serviceDisplay = json['service_display'];
    serviceCharge = json['service_charge'];
    etd = json['etd'];
    image = json['image'];
    by = json['by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['terms'] = this.terms;
    data['service_display'] = this.serviceDisplay;
    data['service_charge'] = this.serviceCharge;
    data['etd'] = this.etd;
    data['image'] = this.image;
    data['by'] = this.by;
    return data;
  }
}
