import 'package:equatable/equatable.dart';
import 'terapis/member.dart';

class StoryModel extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String description;
  final String cover;
  final String created;
  final String updated;
  final Member terapis;

  StoryModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.cover,
    this.created,
    this.updated,
    this.terapis,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        id: json['id'],
        title: json['title'],
        slug: json['slug'],
        description: json['description'],
        cover: json['cover'],
        created: json['created'],
        updated: json['updated'],
        terapis: json['terapis'] != null
            ? Member.fromJson(json["terapis"])
            : null,
      );

  @override
  List<Object> get props => [
        this.id,
        this.title,
        this.slug,
        this.description,
        this.cover,
        this.created,
        this.updated,
        this.terapis,
      ];
}

List<StoryModel> listStoryMockUp = [
  // StoryModel(
  //     label: "Seminggu Puntir Sakit Jantung Hilang",
  //     waktu: "Minggu, 07 Maret 2021 - 12:30",
  //     user: "Rendy Wira",
  //     area: "Bandung",
  //     imageUrl: "assets/images/story.png",
  //     tags: ['Jantung', 'Diabetes']),
  // StoryModel(
  //     label: "Seminggu Puntir Sakit Jantung Hilang",
  //     waktu: "Minggu, 07 Maret 2021 - 12:30",
  //     user: "Rendy Wira",
  //     area: "Bandung",
  //     imageUrl: "assets/images/story.png",
  //     tags: ['Jantung', 'Diabetes']),
  // StoryModel(
  //     label: "Seminggu Puntir Sakit Jantung Hilang",
  //     waktu: "Minggu, 07 Maret 2021 - 12:30",
  //     user: "Rendy Wira",
  //     area: "Bandung",
  //     imageUrl: "assets/images/story.png",
  //     tags: ['Jantung', 'Diabetes']),
  // StoryModel(
  //     label: "Seminggu Puntir Sakit Jantung Hilang",
  //     waktu: "Minggu, 07 Maret 2021 - 12:30",
  //     user: "Rendy Wira",
  //     area: "Bandung",
  //     imageUrl: "assets/images/story.png",
  //     tags: ['Jantung', 'Diabetes']),
];
