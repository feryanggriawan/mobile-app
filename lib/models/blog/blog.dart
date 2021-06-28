import 'package:tsi_mobile/models/blog/writer.dart';

class Blog {
  int id;
  String title;
  String slug;
  String description;
  String cover;
  String created;
  String updated;
  Writer writer;

  Blog(
      {this.id,
      this.title,
      this.slug,
      this.description,
      this.cover,
      this.created,
      this.updated,
      this.writer});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    cover = json['cover'];
    created = json['created'];
    updated = json['updated'];
    writer =
        json['writer'] != null ? new Writer.fromJson(json['writer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['cover'] = this.cover;
    data['created'] = this.created;
    data['updated'] = this.updated;
    if (this.writer != null) {
      data['writer'] = this.writer.toJson();
    }
    return data;
  }
}
