class Category {
  int id;
  String title;
  String slug;
  String description;
  String keyword;
  String icon;
  String status;

  Category(
      {this.id,
        this.title,
        this.slug,
        this.description,
        this.keyword,
        this.icon,
        this.status});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    keyword = json['keyword'];
    icon = json['icon'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['keyword'] = this.keyword;
    data['icon'] = this.icon;
    data['status'] = this.status;
    return data;
  }
}
