import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/controller/level1_controller.dart';
import 'package:quiz_fake_news/logic/score.dart';
import 'package:quiz_fake_news/models/types_questions/classic_question.dart';
import 'package:quiz_fake_news/pages/game_over.dart';
import 'package:quiz_fake_news/pages/common_actions.dart';
import 'package:quiz_fake_news/pages/time_is_up.dart';
import 'package:quiz_fake_news/widgets/counter_time.dart';
import 'package:quiz_fake_news/widgets/question_description.dart';
import 'package:quiz_fake_news/widgets/stop_question.dart';

import '../congrulations/congrulations_nivel1.dart';

LogicScoreQuiz logicScoreQuiz = LogicScoreQuiz();

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final controller = Level1Controller();

  int _counter = 0;
  late Timer _timer;
  int _questionNumber = 0;

  bool status = true;
  bool statusRight = false;
  bool resetTime = false;
  int totalScoreLevel1 = 0;

  void _startTimer() {
    _counter = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        totalScoreLevel1 = logicScoreQuiz.totalScore();
        logicScoreQuiz.resetScore();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                TimeIsUp(score: logicScoreQuiz.totalScore(), time: _timer)));

        _timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    logicScoreQuiz.resetScore();
    controller.start();
    _startTimer();
  }

  _success() {
    List<ClassicQuestion> _classicQuestionBank = controller.todos;

    void nextQuestion() {
      if (_questionNumber < _classicQuestionBank.length - 1) {
        print(_classicQuestionBank.length);
        _questionNumber++;
      }
    }

    bool secondQuestion() {
      if (_questionNumber == 0) {
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

    int getPointAnswer() {
      return _classicQuestionBank[_questionNumber].questionPoint;
    }

    int getPointSkip() {
      return _classicQuestionBank[_questionNumber].skipPoint;
    }

    int getPointStop() {
      return _classicQuestionBank[_questionNumber].stopPoint;
    }

    int getPointRight() {
      return _classicQuestionBank[_questionNumber].rightPoint;
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
      bool correctAnswer = getCorrectAnswer();

      setState(() {
        if (isFinished() == true) {
          if (userPickedAnswer != correctAnswer) {
            _timer.cancel();
            totalScoreLevel1 = logicScoreQuiz.totalScore();
            logicScoreQuiz.resetScore();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GameOver(score: totalScoreLevel1, time: _timer)));
          } else {
            totalScoreLevel1 = logicScoreQuiz.totalScore();
            logicScoreQuiz.resetScore();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CongratulationsNivel1(
                    score: totalScoreLevel1.toString(), time: _timer)));

            _timer.cancel();
            reset();
          }
        } else {
          if (userPickedAnswer == correctAnswer) {
            if (secondQuestion()) {
              enableButtonSkip();
            }
            _timer.cancel();
            logicScoreQuiz.incrementScore(
                logicScoreQuiz.calculationScore(getPointAnswer(), _counter));
          } else {
            _timer.cancel();
            totalScoreLevel1 = logicScoreQuiz.totalScore();
            logicScoreQuiz.resetScore();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GameOver(score: totalScoreLevel1, time: _timer)));
          }
          _timer.cancel();
          _startTimer();
          nextQuestion();
        }
      });
    }

    void whatToDoOnPressedSkip({required Timer time}) {
      time.cancel();
      logicScoreQuiz.decreaseScore(getPointSkip());
      disableButtonSkip();
      nextQuestion();
    }

    void whatToDoOnPressedRight({required Timer time}) {
      time.cancel();
      logicScoreQuiz.incrementScore(
          logicScoreQuiz.calculationScore(getPointRight(), _counter));
      setState(() {
        statusRight = true;
      });
      nextQuestion();
    }

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
          QuestionDescription(description: getQuestionText(), size: 5),
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
                      '-' + getPointSkip().toString() + '\nPULAR',
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
                  StopQuestion(pointsStop: getPointStop(), time: _timer),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      getPointRight().toString() + '\nACERTAR',
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

  stateManagement(Level1State state) {
    Loading commonActions = Loading();

    switch (state) {
      case Level1State.start:
        return commonActions.start();
      case Level1State.loading:
        return commonActions.loading();
      case Level1State.success:
        return _success();
      case Level1State.error:
        return commonActions.error();
      default:
        return commonActions.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}
