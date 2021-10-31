import 'package:quiz_fake_news/logic/types_questions/classic_question.dart';

class LogicClassicQuestionQuiz {
  int _questionNumber = 0;

  List<ClassicQuestion> _classicQuestionBank = [
    ClassicQuestion(
      4000,
      30,
      5000,
      3000,
      4000,
      'Fake News são notícias falsas que passam por notícias verdadeiras',
      true,
    ),
    ClassicQuestion(
      4000,
      60,
      5000,
      3000,
      4000,
      'Nas redes sociais, são criados perfis falsos (com fotos, dados pessoais e publicações diárias) que começam a interagir com outras pessoas para dar veracidade. Depois, os perfis começam a espalhar notícias e vídeos de sites falsos e incentivam seus contatos a fazerem o mesmo.',
      true,
    ),
    ClassicQuestion(
      4000,
      60,
      5000,
      3000,
      4000,
      'Movimentos antivacinação voltaram a crescer nos últimos anos. Algumas pessoas contrárias ao uso de vacinas disseminam notícias falsas e propagam suas visões de que vacinar a população faz mal, o que é um problema grave, pois a resistência à vacinação coloca em perigo a população.',
      true,
    ),
    ClassicQuestion(
      4000,
      30,
      5000,
      3000,
      4000,
      'Quando se lê um artigo e se nota que a manchete não corresponde ao tópico do texto, é provavelmente verdadeiro.',
      false,
    ),
    ClassicQuestion(
      4000,
      60,
      5000,
      3000,
      4000,
      'Verificar duas vezes o URL. Se não coincidir com o meio de divulgação de notícias, pode ser umsinal de que não é real.',
      true,
    ),
  ];

  void nextQuestion() {
    if (_questionNumber < _classicQuestionBank.length - 1) {
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

  String getQuestionText() {
    return _classicQuestionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _classicQuestionBank[_questionNumber].questionAnswer;
  }

  int getCounter() {
    return _classicQuestionBank[_questionNumber].counter;
  }

  int getPointAnswer() {
    return _classicQuestionBank[_questionNumber].questionPoint;
  }

  int getPointSkip() {
    return _classicQuestionBank[_questionNumber].skip;
  }

  int getPointStop() {
    return _classicQuestionBank[_questionNumber].stop;
  }

  int getPointRight() {
    return _classicQuestionBank[_questionNumber].right;
  }

  bool isFinished() {
    if (_questionNumber >= _classicQuestionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
