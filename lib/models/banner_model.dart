import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final String title;
  final String imageUrl;
  final String location;

  BannerModel({this.title, this.imageUrl, this.location});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
      title: json['title'],
      imageUrl: json['image'],
      location: json['location']);

  @override
  List<Object> get props => [title, imageUrl, location];
}
