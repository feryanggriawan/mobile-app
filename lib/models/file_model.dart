import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final int id;
  final String file;

  FileModel({this.id, this.file});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(file: json['file'], id: json['id']);
  }

  @override
  List<Object> get props => [id, file];
}
