import 'package:equatable/equatable.dart';

class ProvinceModel extends Equatable {
  final int id;
  final String name;
  final String slug;

  ProvinceModel({this.id, this.name, this.slug});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      ProvinceModel(id: json['id'], name: json['name'], slug: json['slug']);

  @override
  List<Object> get props => [id, name, slug];
}
