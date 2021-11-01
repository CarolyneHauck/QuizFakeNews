import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/logic/logic_classic_questions_with_image.dart';
import 'package:quiz_fake_news/pages/time_is_up.dart';
import 'package:quiz_fake_news/widgets/counter_time.dart';
import 'package:quiz_fake_news/widgets/question_image.dart';
import 'package:quiz_fake_news/widgets/stop_question.dart';

import 'classic_quizzler.dart';
import 'congrulations/congrulations_nivel2.dart';
import 'game_over.dart';

LogicClassicQuestionWithImageQuiz classicQuestionWithImageQuiz =
    LogicClassicQuestionWithImageQuiz();

class QuizzlerWithImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizWithImagePage(),
        ),
      ),
    );
  }
}

class QuizWithImagePage extends StatefulWidget {
  @override
  _QuizWithImagePageState createState() => _QuizWithImagePageState();
}

class _QuizWithImagePageState extends State<QuizWithImagePage> {
  bool status = false;
  bool statusRight = false;
  bool resetTime = false;

  int _counter = 0;
  late Timer _timer;
  int finalScore = 0;

  void _startTimer() {
    _counter = classicQuestionWithImageQuiz.getCounter();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        if (classicQuestionWithImageQuiz.isFinished() == false) {
          _timer.cancel();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TimeIsUp(
                    score: logicScoreQuiz.totalScore(),
                    time: timer,
                  )));
        }
        _timer.cancel();
      }
    });
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = classicQuestionWithImageQuiz.getCorrectAnswer();

    setState(() {
      if (classicQuestionWithImageQuiz.isFinished() == true) {
        logicScoreQuiz.incrementScore(logicScoreQuiz.calculationScore(
            classicQuestionWithImageQuiz.getPointRight(), _counter));

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CongratulationsNivel2(
                score: logicScoreQuiz.totalScore().toString(), time: _timer)));

        _timer.cancel();
        classicQuestionWithImageQuiz.reset();
      } else {
        if (userPickedAnswer == correctAnswer) {
          if (classicQuestionQuiz.secondQuestion()) {
            setState(() {
              status = false;
            });
          }
          _timer.cancel();
          logicScoreQuiz.incrementScore(logicScoreQuiz.calculationScore(
              classicQuestionWithImageQuiz.getPointRight(), _counter));
        } else {
          _timer.cancel();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  GameOver(score: logicScoreQuiz.totalScore(), time: _timer)));
        }

        _timer.cancel();
        _startTimer();
        classicQuestionWithImageQuiz.nextQuestion();
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (classicQuestionWithImageQuiz.isFinished() == true) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CongratulationsNivel2(
                score: logicScoreQuiz.totalScore().toString(), time: _timer)));

        classicQuestionWithImageQuiz.reset();
      } else {
        _timer.cancel();
        _startTimer();
        classicQuestionWithImageQuiz.nextQuestion();
      }
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CounterPoints(points: logicScoreQuiz.totalScore().toString()),
          QuestionImage(),
          Expanded(
            flex: 1,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      '$_counter',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Medium',
                          fontSize: 22),
                    ),
                    radius: 22.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          "VERDADEIRO",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Medium',
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(true);
                  },
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          "FALSO",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Medium',
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(false);
                  },
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      '-' +
                          classicQuestionWithImageQuiz
                              .getPointSkip()
                              .toString() +
                          '\nPULAR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: status
                        ? null
                        : () => whatToDoOnPressedSkip(time: _timer),
                  ),
                  StopQuestion(
                      pointsStop: classicQuestionWithImageQuiz.getPointStop(),
                      time: _timer),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      classicQuestionWithImageQuiz.getPointRight().toString() +
                          '\nACERTAR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: statusRight
                        ? null
                        : () => whatToDoOnPressedRight(time: _timer),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void whatToDoOnPressedSkip({required Timer time}) {
    time.cancel();
    logicScoreQuiz.decreaseScore(classicQuestionWithImageQuiz.getPointSkip());
    setState(() {
      status = true;
    });
    nextQuestion();
  }

  void whatToDoOnPressedRight({required Timer time}) {
    time.cancel();
    logicScoreQuiz.incrementScore(logicScoreQuiz.calculationScore(
        classicQuestionWithImageQuiz.getPointRight(), _counter));
    setState(() {
      statusRight = true;
    });
    nextQuestion();
  }
}
