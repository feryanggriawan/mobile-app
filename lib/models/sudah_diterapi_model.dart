

class SudahDiterapiModel {
  final String date;
  final String hour;
  final String imageUrl;
  final String name;
  final String gender;
  final int age;
  final List<String> disease;

  SudahDiterapiModel({
    this.date,
    this.hour,
    this.imageUrl,
    this.name,
    this.gender,
    this.age,
    this.disease,
  });
}

List<SudahDiterapiModel> sudahDiterapiList = [
  SudahDiterapiModel(
      name: "Sukiman",
      date: "Minggu, 07 Maret 2021",
      hour: "12:30",
      imageUrl: "profile1.png",
      age: 32,
      gender: "Pria",
      disease: ["Sakit Kepala", "Maag", "Jantung"]),
  SudahDiterapiModel(
      name: "Sukiman",
      date: "Minggu, 07 Maret 2021",
      hour: "12:30",
      imageUrl: "profile1.png",
      age: 32,
      gender: "Pria",
      disease: ["Sakit Kepala", "Maag", "Jantung"]),
  SudahDiterapiModel(
      name: "Sukiman",
      date: "Minggu, 07 Maret 2021",
      hour: "12:30",
      imageUrl: "profile1.png",
      age: 32,
      gender: "Pria",
      disease: ["Sakit Kepala", "Maag", "Jantung"]),
];
