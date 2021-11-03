class ClassicQuestionWithImage {
  String image;
  bool questionAnswer;
  int questionPoint;
  int counter;
  int skipPoint;
  int stopPoint;
  int rightPoint;

  ClassicQuestionWithImage({
    required this.questionPoint,
    required this.counter,
    required this.skipPoint,
    required this.stopPoint,
    required this.rightPoint,
    required this.image,
    required this.questionAnswer,
  });

  factory ClassicQuestionWithImage.fromJson(Map<String, dynamic> json) {
    return ClassicQuestionWithImage(
      counter: json['counter'] as int,
      questionAnswer: json['questionAnswer'] as bool,
      questionPoint: json['questionPoint'] as int,
      image: json['image'] as String,
      skipPoint: json['skipPoint'] as int,
      stopPoint: json['stopPoint'] as int,
      rightPoint: json['rightPoint'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['questionAnswer'] = this.questionAnswer;
    data['questionPoint'] = this.questionPoint;
    data['image'] = this.image;
    data['rightPoint'] = this.rightPoint;
    data['skipPoint'] = this.skipPoint;
    data['stopPoint'] = this.stopPoint;
    return data;
  }
}
