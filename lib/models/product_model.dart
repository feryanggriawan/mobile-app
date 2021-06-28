import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'file_model.dart';

// ignore: must_be_immutable
class ProductModel extends Equatable {
  final int id;
  final String title,
      code,
      basePrice,
      grosirPrice,
      price,
      stock,
      weight,
      description,
      manfaat,
      keyword,
      startDiscount,
      endDiscount,
      status;

  // Jika Base Price > price
  final bool isDiscount;

  // Split Manfaat to List
  final List<String> listManfaat;

  final List<FileModel> images;

  List<Variant> variant;

  ProductModel(
      {this.id,
      this.title,
      this.code,
      this.basePrice,
      this.grosirPrice,
      this.price,
      this.stock,
      this.weight,
      this.description,
      this.manfaat,
      this.keyword,
      this.startDiscount,
      this.endDiscount,
      this.status,
      this.isDiscount,
      this.variant,
      this.images,
      this.listManfaat});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        code: json['code'],
        basePrice: json['base_price'],
        grosirPrice: json['grosir_price'],
        price: json['price'],
        stock: json['stock'],
        weight: json['weight'],
        description: parseHtmlExtension(json['description']),
        manfaat: parseHtmlExtension(json['manfaat']),
        keyword: json['keyword'],
        startDiscount: json['start_discount'],
        endDiscount: json['end_discount'],
        status: json['status'],
        isDiscount: checkDiscountExtension(
            basePrice: json['base_price'], price: json['price']),
        images: (json['count_image'] > 0)
            ? (json['image'] as Iterable)
                .map((e) => FileModel.fromJson(e))
                .toList()
            : Null,
        listManfaat: (json['manfaat'] != null)
            ? splitTextExtension(parseHtmlExtension(json['manfaat']), "-")
            : Null,
        variant: (json["variant"] != null)
            ? (json['variant'] as Iterable).map((v) => Variant.fromJson(v)).toList()
            : [],
      );

  @override
  List<Object> get props => [
        id,
        title,
        code,
        basePrice,
        grosirPrice,
        price,
        stock,
        weight,
        description,
        manfaat,
        keyword,
        startDiscount,
        endDiscount,
        images,
        status,
        isDiscount,
        listManfaat
      ];
}

class Variant {
  int id;
  String code;
  String type;
  String title;
  String attribute;
  String basePrice;
  String grosirPrice;
  String price;
  String stock;
  String weight;
  String description;
  String cover;

  Variant(
      {this.id,
      this.code,
      this.type,
      this.title,
      this.attribute,
      this.basePrice,
      this.grosirPrice,
      this.price,
      this.stock,
      this.weight,
      this.description,
      this.cover});

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    title = json['title'];
    attribute = json['attribute'];
    basePrice = json['base_price'];
    grosirPrice = json['grosir_price'];
    price = json['price'];
    stock = json['stock'];
    weight = json['weight'];
    description = json['description'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['title'] = this.title;
    data['attribute'] = this.attribute;
    data['base_price'] = this.basePrice;
    data['grosir_price'] = this.grosirPrice;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['cover'] = this.cover;
    return data;
  }
}

// List<ProductModel> listProdukMockUp = [
//   ProductModel(
//       title: "Madu Hutan Lindung",
//       isDicon: true,
//       discon: 180000,
//       price: 150000),
//   ProductModel(
//       title: "Madu Hutan Lindung",
//       isDicon: true,
//       discon: 180000,
//       price: 150000),
//   ProductModel(
//       title: "Madu Hutan Lindung",
//       isDicon: true,
//       discon: 180000,
//       price: 150000),
//   ProductModel(
//       title: "Madu Hutan Lindung",
//       isDicon: true,
//       discon: 180000,
//       price: 150000),
//   ProductModel(
//       title: "Madu Hutan Lindung",
//       isDicon: true,
//       discon: 180000,
//       price: 150000),
//   ProductModel(
//       title: "Madu Hutan Lindung",
//       isDicon: true,
//       discon: 180000,
//       price: 150000),
// ];
