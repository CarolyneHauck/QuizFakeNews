import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/controller/level2_controller.dart';
import 'package:quiz_fake_news/logic/score.dart';
import 'package:quiz_fake_news/models/types_questions/classic_with_image.dart';
import 'package:quiz_fake_news/pages/congrulations/congrulations_nivel2.dart';
import 'package:quiz_fake_news/pages/game_over.dart';
import 'package:quiz_fake_news/pages/common_actions.dart';
import 'package:quiz_fake_news/pages/time_is_up.dart';
import 'package:quiz_fake_news/widgets/counter_time.dart';
import 'package:quiz_fake_news/widgets/stop_question.dart';

LogicScoreQuiz logicScoreQuiz = LogicScoreQuiz();

class ClassicQuestionWithImagePage extends StatefulWidget {
  @override
  _ClassicQuestionWithImagePageState createState() =>
      _ClassicQuestionWithImagePageState();
}

class _ClassicQuestionWithImagePageState
    extends State<ClassicQuestionWithImagePage> {
  final controller = Level2Controller();

  int _counter = 0;
  late Timer _timer;
  int _questionNumber = 0;

  bool status = true;
  bool statusRight = false;
  bool resetTime = false;
  int totalScoreLevel2 = 0;

  void _startTimer() {
    _counter = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        totalScoreLevel2 = logicScoreQuiz.totalScore();
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
    controller.startLevel2();
    _startTimer();
  }

  _success() {
    List<ClassicQuestionWithImage> _classicQuestionWithImage =
        controller.classicQuestionWithImage;

    bool secondQuestion() {
      if (_questionNumber == 0) {
        return true;
      } else {
        return false;
      }
    }

    bool getCorrectAnswer() {
      return _classicQuestionWithImage[_questionNumber].questionAnswer;
    }

    int getPointSkip() {
      return _classicQuestionWithImage[_questionNumber].skipPoint;
    }

    int getPointStop() {
      return _classicQuestionWithImage[_questionNumber].stopPoint;
    }

    int getPointRight() {
      return _classicQuestionWithImage[_questionNumber].rightPoint;
    }

    bool isFinished() {
      if (_questionNumber >= _classicQuestionWithImage.length - 1) {
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

    Image getImage() {
      String url = _classicQuestionWithImage[_questionNumber].image;
      Image image = Image.network(url);
      return image;
    }

    void nextQuestion() {
      if (_questionNumber < _classicQuestionWithImage.length - 1) {
        print(_classicQuestionWithImage.length);
        _questionNumber++;
      }
    }

    void checkAnswer(bool userPickedAnswer) {
      bool correctAnswer = getCorrectAnswer();

      setState(() {
        if (isFinished() == true) {
          if (userPickedAnswer != correctAnswer) {
            _timer.cancel();
            totalScoreLevel2 = logicScoreQuiz.totalScore();
            logicScoreQuiz.resetScore();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    GameOver(score: totalScoreLevel2, time: _timer)));
          }
          totalScoreLevel2 = logicScoreQuiz.totalScore();
          logicScoreQuiz.resetScore();
          logicScoreQuiz.incrementScore(
              logicScoreQuiz.calculationScore(getPointRight(), _counter));

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CongratulationsNivel2(
                  score: totalScoreLevel2.toString(), time: _timer)));

          _timer.cancel();
          reset();
        } else {
          if (userPickedAnswer == correctAnswer) {
            if (secondQuestion()) {
              setState(() {
                status = false;
              });
            }
            _timer.cancel();
            logicScoreQuiz.incrementScore(
                logicScoreQuiz.calculationScore(getPointRight(), _counter));
          } else {
            _timer.cancel();
            totalScoreLevel2 = logicScoreQuiz.totalScore();
            logicScoreQuiz.resetScore();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GameOver(
                    score: logicScoreQuiz.totalScore(), time: _timer)));
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
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                  color: Colors.blueGrey,
                ),
                child: getImage(),
              ),
            ),
          ),
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

  stateManagement(Level2State state) {
    Loading commonActions = Loading();

    switch (state) {
      case Level2State.start:
        return commonActions.start();
      case Level2State.loading:
        return commonActions.loading();
      case Level2State.success:
        return _success();
      case Level2State.error:
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
