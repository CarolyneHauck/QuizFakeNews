import 'package:quiz_fake_news/logic/types_questions/question.dart';

class ClassicQuestion extends Question {
  String questionText;
  bool questionAnswer;

  ClassicQuestion(int questionPoint, int counter, int skip, int stop, int right,
      this.questionText, this.questionAnswer)
      : super(questionPoint, counter, skip, stop, right);
}
