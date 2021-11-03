class ClassicQuestion {
  String questionText;
  bool questionAnswer;
  int questionPoint;
  int id;
  int counter;
  int skipPoint;
  int stopPoint;
  int rightPoint;

  ClassicQuestion({
    required this.questionPoint,
    required this.counter,
    required this.skipPoint,
    required this.stopPoint,
    required this.rightPoint,
    required this.questionText,
    required this.questionAnswer,
    required this.id,
  });

  factory ClassicQuestion.fromJson(Map<String, dynamic> json) {
    return ClassicQuestion(
      counter: json['counter'] as int,
      questionAnswer: json['questionAnswer'] as bool,
      questionPoint: json['questionPoint'] as int,
      questionText: json['questionText'] as String,
      skipPoint: json['skipPoint'] as int,
      stopPoint: json['stopPoint'] as int,
      rightPoint: json['rightPoint'] as int,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['questionAnswer'] = this.questionAnswer;
    data['questionPoint'] = this.questionPoint;
    data['questionText'] = this.questionText;
    data['rightPoint'] = this.rightPoint;
    data['skipPoint'] = this.skipPoint;
    data['stopPoint'] = this.stopPoint;
    data['id'] = this.id;
    return data;
  }
}
