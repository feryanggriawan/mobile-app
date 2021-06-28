class PaymentMethod {
  int id;
  String token;
  String name;
  String brand;
  String label;
  String an;
  String nomor;
  String description;
  String image;

  PaymentMethod(
      {this.id,
      this.token,
      this.name,
      this.brand,
      this.label,
      this.an,
      this.nomor,
      this.description,
      this.image});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    name = json['name'];
    brand = json['brand'];
    label = json['label'];
    an = json['an'];
    nomor = json['nomor'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['label'] = this.label;
    data['an'] = this.an;
    data['nomor'] = this.nomor;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
