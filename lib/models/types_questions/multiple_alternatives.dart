class MultipleAlternative {
  String questionDescription;
  String answer;
  String alternativeA;
  String alternativeB;
  String alternativeC;
  String alternativeD;
  int questionPoint;
  int counter;
  int skipPoint;
  int stopPoint;
  int rightPoint;

  MultipleAlternative({
    required this.questionPoint,
    required this.counter,
    required this.skipPoint,
    required this.stopPoint,
    required this.rightPoint,
    required this.questionDescription,
    required this.answer,
    required this.alternativeA,
    required this.alternativeB,
    required this.alternativeC,
    required this.alternativeD,
  });

  factory MultipleAlternative.fromJson(Map<String, dynamic> json) {
    return MultipleAlternative(
      counter: json['counter'] as int,
      answer: json['answer'] as String,
      questionPoint: json['questionPoint'] as int,
      questionDescription: json['questionDescription'] as String,
      alternativeA: json['alternativeA'] as String,
      alternativeB: json['alternativeB'] as String,
      alternativeC: json['alternativeC'] as String,
      alternativeD: json['alternativeD'] as String,
      skipPoint: json['skipPoint'] as int,
      stopPoint: json['stopPoint'] as int,
      rightPoint: json['rightPoint'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['answer'] = this.answer;
    data['questionPoint'] = this.questionPoint;
    data['questionDescription'] = this.questionDescription;
    data['alternativeA'] = this.alternativeA;
    data['alternativeB'] = this.alternativeB;
    data['alternativeC'] = this.alternativeC;
    data['alternativeD'] = this.alternativeD;
    data['rightPoint'] = this.rightPoint;
    data['skipPoint'] = this.skipPoint;
    data['stopPoint'] = this.stopPoint;
    return data;
  }
}
