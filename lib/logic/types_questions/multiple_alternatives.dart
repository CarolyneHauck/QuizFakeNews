import 'package:quiz_fake_news/logic/types_questions/question.dart';

class MultipleAlternatives extends Question {
  String questionDescription;

  String alternativeA;
  String alternativeB;
  String alternativeC;
  String alternativeD;

  String questionAnswer;

  MultipleAlternatives(
      int questionPoint,
      int counter,
      int skip,
      int stop,
      int right,
      this.questionDescription,
      this.alternativeA,
      this.alternativeB,
      this.alternativeC,
      this.alternativeD,
      this.questionAnswer)
      : super(questionPoint, counter, skip, stop, right);
}
