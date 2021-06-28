import 'package:equatable/equatable.dart';
import 'package:tsi_mobile/extensions/extensions.dart';
import 'file_model.dart';
class CourseModel extends Equatable {
  final int id;
  final String code,
      type,
      title,
      basePrice,
      price,
      live,
      description,
      fasilitas,
      address,
      location,
      keyword,
      status;

  // Jika Base Price > price
  final bool isDiscount;

  // Split Fasilitas
  final List<String> listFasilitas;

  final List<FileModel> images;
  final List<FileModel> videos;

  CourseModel(
      {this.price,
      this.id,
      this.code,
      this.type,
      this.listFasilitas,
      this.title,
      this.address,
      this.basePrice,
      this.description,
      this.fasilitas,
      this.images,
      this.keyword,
      this.live,
      this.location,
      this.isDiscount,
      this.videos,
      this.status});

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json['id'],
        code: json['code'],
        type: json['type'],
        title: json['title'],
        basePrice: json['base_price'],
        price: json['price'],
        live: json['live'],
        description: parseHtmlExtension(json['description']),
        fasilitas: parseHtmlExtension(json['fasilitas']),
        address: json['address'],
        location: json['location'],
        keyword: parseHtmlExtension(json['keyword']),
        isDiscount: checkDiscountExtension(
            basePrice: json['base_price'], price: json['price']),
        status: json['status'],
        listFasilitas: (json['fasilitas'] != null)
            ? splitTextExtension(parseHtmlExtension(json['fasilitas']), "-")
            : Null,
        images: (json['count_image'] > 0)
            ? (json['image'] as Iterable)
                .map((e) => FileModel.fromJson(e))
                .toList()
            : Null,
        // videos: (json['count_video'] > 0)
        //     ? (json['video'] as Iterable)
        //         .map((e) => FileModel.fromJson(e))
        //         .toList()
        //     : Null,
      );

  @override
  List<Object> get props => [
        price,
        id,
        code,
        type,
        title,
        address,
        basePrice,
        description,
        fasilitas,
        images,
        keyword,
        isDiscount,
        live,
        location,
        status,
        videos,
        listFasilitas
      ];
}

// List<CourseModel> listPelatihanOnlineMockUp = [
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: true,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: true,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: true,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
// ];

// List<CourseModel> listPelatihanOfflineMockUp = [
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: false,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: false,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: false,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
// ];

// List<CourseModel> listPelatihanTerdekatOnlineMockUp = [
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: true,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: true,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
// ];

// List<CourseModel> listPelatihanTerdekatOfflineMockUp = [
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: false,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
//   CourseModel(
//       area: "Pontianak",
//       discon: 2800000,
//       disconDay: 3,
//       isDiscon: true,
//       imageUrl: "assets/images/pelatihan.png",
//       isOnline: false,
//       price: 2500000,
//       title: "Mengenali 4 Kelompok Penyimpangan Tubuh Manusia"),
// ];

// ];
