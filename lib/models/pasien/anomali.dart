class Anomali {
  String thorax;
  String lumbar;

  Anomali({this.thorax, this.lumbar});

  Anomali.fromJson(Map<String, dynamic> json) {
    thorax = json['thorax'];
    lumbar = json['lumbar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thorax'] = this.thorax;
    data['lumbar'] = this.lumbar;
    return data;
  }
}