import 'package:flutter/material.dart';
import 'package:quiz_fake_news/logic/types_questions/question.dart';

class ClassicQuestionWithImage extends Question {
  Image image;
  bool questionAnswer;

  ClassicQuestionWithImage(this.image, this.questionAnswer, int questionPoint,
      int counter, int skip, int stop, int right)
      : super(questionPoint, counter, skip, stop, right);
}
