import 'package:flutter/material.dart';
import 'package:quiz_fake_news/logic/types_questions/classic_with_image.dart';

class LogicClassicQuestionWithImageQuiz {
  int _questionNumber = 0;

  List<ClassicQuestionWithImage> _classicQuestionWithImageBank = [
    ClassicQuestionWithImage(
        Image(
          image: AssetImage('images/questions/fake1.png'),
        ),
        false,
        4000,
        30,
        5000,
        2000,
        5000),
    ClassicQuestionWithImage(
        Image(
          image: AssetImage('images/questions/otherfake.png'),
        ),
        false,
        4000,
        60,
        5000,
        2000,
        5000),
  ];

  void nextQuestion() {
    if (_questionNumber < _classicQuestionWithImageBank.length - 1) {
      _questionNumber++;
    }
  }

  bool secondQuestion() {
    if (_questionNumber == 1) {
      return true;
    } else {
      return false;
    }
  }

  Image getImage() {
    return _classicQuestionWithImageBank[_questionNumber].image;
  }

  bool getCorrectAnswer() {
    return _classicQuestionWithImageBank[_questionNumber].questionAnswer;
  }

  int getCounter() {
    return _classicQuestionWithImageBank[_questionNumber].counter;
  }

  int getPointAnswer() {
    return _classicQuestionWithImageBank[_questionNumber].questionPoint;
  }

  int getPointSkip() {
    return _classicQuestionWithImageBank[_questionNumber].skip;
  }

  int getPointStop() {
    return _classicQuestionWithImageBank[_questionNumber].stop;
  }

  int getPointRight() {
    return _classicQuestionWithImageBank[_questionNumber].right;
  }

  bool isFinished() {
    if (_questionNumber >= _classicQuestionWithImageBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
