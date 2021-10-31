import 'package:quiz_fake_news/logic/types_questions/multiple_alternatives.dart';

class LogicMultipleAlternativesQuiz {
  int _questionNumber = 0;

  List<MultipleAlternatives> _multipleAlternativesBank = [
    MultipleAlternatives(
        4000,
        60,
        5000,
        1000,
        5000,
        'As fake news sao propagadas principalmente por meio de',
        'Canais no youtube',
        'Páginas do facebook/instagram',
        'Redes sociais',
        'Pelos canais de televisão',
        'Redes sociais'),
    MultipleAlternatives(
        4000,
        60,
        5000,
        3000,
        4000,
        'As pessoas mais prejudicadas pelas Fakes News são as',
        'Figuras da comunidade científica',
        'Figuras públicas',
        'Figuras do entretenimento',
        'Pessoas comuns',
        'Figuras públicas'),
    MultipleAlternatives(
        4000,
        60,
        5000,
        3000,
        4000,
        'O termo Fake News ganhou força mundialmente em 2016, com a corrida presidencial de qual país?',
        'Brasil',
        'Estados Unidos',
        'China',
        'Russia',
        'Estados Unidos'),
  ];

  void nextQuestion() {
    if (_questionNumber < _multipleAlternativesBank.length - 1) {
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

  String getQuestionDescription() {
    return _multipleAlternativesBank[_questionNumber].questionDescription;
  }

  String getQuestionAnswer() {
    return _multipleAlternativesBank[_questionNumber].questionAnswer;
  }

  String getAlternativeA() {
    return _multipleAlternativesBank[_questionNumber].alternativeA;
  }

  String getAlternativeB() {
    return _multipleAlternativesBank[_questionNumber].alternativeB;
  }

  String getAlternativeC() {
    return _multipleAlternativesBank[_questionNumber].alternativeC;
  }

  String getAlternativeD() {
    return _multipleAlternativesBank[_questionNumber].alternativeD;
  }

  int getCounter() {
    return _multipleAlternativesBank[_questionNumber].counter;
  }

  int getPointAnswer() {
    return _multipleAlternativesBank[_questionNumber].questionPoint;
  }

  int getPointSkip() {
    return _multipleAlternativesBank[_questionNumber].skip;
  }

  int getPointStop() {
    return _multipleAlternativesBank[_questionNumber].stop;
  }

  int getPointRight() {
    return _multipleAlternativesBank[_questionNumber].right;
  }

  bool isFinished() {
    if (_questionNumber >= _multipleAlternativesBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
