class Ranking {
  String name;
  int points;

  Ranking({required this.name, required this.points});

  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
      name: json['name'] as String,
      points: json['points'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['points'] = this.points;
    return data;
  }
}
