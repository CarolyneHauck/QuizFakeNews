import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/logic/logic_classic_questions.dart';
import 'package:quiz_fake_news/logic/score.dart';
import 'package:quiz_fake_news/pages/time_is_up.dart';
import 'package:quiz_fake_news/widgets/counter_time.dart';
import 'package:quiz_fake_news/widgets/question_description.dart';
import 'package:quiz_fake_news/widgets/stop_question.dart';

import 'congrulations/congrulations_nivel1.dart';
import 'game_over.dart';

LogicClassicQuestionQuiz classicQuestionQuiz = LogicClassicQuestionQuiz();

LogicScoreQuiz logicScoreQuiz = LogicScoreQuiz();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool status = true;
  bool statusRight = false;
  bool resetTime = false;

  int _counter = 0;
  late Timer _timer;

  void _startTimer() {
    _counter = classicQuestionQuiz.getCounter();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        if (classicQuestionQuiz.isFinished() == false) {
          _timer.cancel();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  TimeIsUp(score: logicScoreQuiz.totalScore(), time: _timer)));
        }
        _timer.cancel();
      }
    });
  }

  void disableButtonSkip() {
    setState(() {
      status = true;
    });
  }

  void enableButtonSkip() {
    setState(() {
      status = false;
    });
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = classicQuestionQuiz.getCorrectAnswer();

    setState(() {
      if (classicQuestionQuiz.isFinished() == true) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CongratulationsNivel1(
                score: logicScoreQuiz.totalScore().toString(), time: _timer)));

        _timer.cancel();
        classicQuestionQuiz.reset();
      } else {
        if (userPickedAnswer == correctAnswer) {
          if (classicQuestionQuiz.secondQuestion()) {
            enableButtonSkip();
          }
          _timer.cancel();
          logicScoreQuiz.incrementScore(logicScoreQuiz.calculationScore(
              classicQuestionQuiz.getPointAnswer(), _counter));
        } else {
          _timer.cancel();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  GameOver(score: logicScoreQuiz.totalScore(), time: _timer)));
        }
        _timer.cancel();
        _startTimer();
        classicQuestionQuiz.nextQuestion();
      }
    });
  }

  void nextQuestion() {
    setState(() {
      _timer.cancel();
      _startTimer();
      disableButtonSkip();
      classicQuestionQuiz.nextQuestion();
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
          QuestionDescription(
              description: classicQuestionQuiz.getQuestionText(), size: 5),
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
                          classicQuestionQuiz.getPointSkip().toString() +
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
                      pointsStop: classicQuestionQuiz.getPointStop(),
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
                      classicQuestionQuiz.getPointRight().toString() +
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
    logicScoreQuiz.decreaseScore(classicQuestionQuiz.getPointSkip());
    disableButtonSkip();
    nextQuestion();
  }

  void whatToDoOnPressedRight({required Timer time}) {
    time.cancel();
    logicScoreQuiz.incrementScore(logicScoreQuiz.calculationScore(
        classicQuestionQuiz.getPointRight(), _counter));
    setState(() {
      statusRight = true;
    });
    nextQuestion();
  }
}
