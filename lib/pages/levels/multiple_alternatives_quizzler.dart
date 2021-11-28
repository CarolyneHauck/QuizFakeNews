import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/controller/level3_controller.dart';
import 'package:quiz_fake_news/logic/score.dart';
import 'package:quiz_fake_news/models/types_questions/multiple_alternatives.dart';
import 'package:quiz_fake_news/pages/congrulations/congrulations_final.dart';
import 'package:quiz_fake_news/pages/common_actions.dart';
import 'package:quiz_fake_news/pages/gameover/game_over_level3.dart';
import 'package:quiz_fake_news/pages/time_is_up.dart';
import 'package:quiz_fake_news/widgets/counter_time.dart';
import 'package:quiz_fake_news/widgets/question_description.dart';
import 'package:quiz_fake_news/widgets/stop_question.dart';

LogicScoreQuiz logicScoreQuiz = LogicScoreQuiz();

class MultipleAlternativesPage extends StatefulWidget {
  @override
  _MultipleAlternativesPageState createState() =>
      _MultipleAlternativesPageState();
}

class _MultipleAlternativesPageState extends State<MultipleAlternativesPage> {
  final controller = Level3Controller();

  int _counter = 0;
  late Timer _timer;
  int _questionNumber = 0;

  bool status = true;
  bool statusRight = false;
  bool resetTime = false;
  int totalScoreLevel3 = 0;

  void _startTimer() {
    _counter = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        totalScoreLevel3 = logicScoreQuiz.totalScore();
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
    controller.startLevel3();
    _startTimer();
  }

  _success() {
    List<MultipleAlternative> _multipleAlternatives =
        controller.multipleAlternatives;

    void nextQuestion() {
      if (_questionNumber < _multipleAlternatives.length - 1) {
        print(_multipleAlternatives.length);
        _questionNumber++;
      }
    }

    String getQuestionDescription() {
      return _multipleAlternatives[_questionNumber].questionDescription;
    }

    String getQuestionAnswer() {
      return _multipleAlternatives[_questionNumber].answer;
    }

    String getAlternativeA() {
      return _multipleAlternatives[_questionNumber].alternativeA;
    }

    String getAlternativeB() {
      return _multipleAlternatives[_questionNumber].alternativeB;
    }

    String getAlternativeC() {
      return _multipleAlternatives[_questionNumber].alternativeC;
    }

    String getAlternativeD() {
      return _multipleAlternatives[_questionNumber].alternativeD;
    }

    int getPointSkip() {
      return _multipleAlternatives[_questionNumber].skipPoint;
    }

    int getPointStop() {
      return _multipleAlternatives[_questionNumber].stopPoint;
    }

    int getPointRight() {
      return _multipleAlternatives[_questionNumber].rightPoint;
    }

    bool isFinished() {
      if (_questionNumber >= _multipleAlternatives.length - 1) {
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

    bool secondQuestion() {
      if (_questionNumber == 0) {
        return true;
      } else {
        return false;
      }
    }

    void checkAnswerWithMultipleAlternatives(String userPickedAnswer) {
      String correctAnswer = getQuestionAnswer();
      String question = getQuestionDescription();

      setState(() {
        if (isFinished() == true) {
          totalScoreLevel3 = logicScoreQuiz.totalScore();
          logicScoreQuiz.resetScore();

          logicScoreQuiz.incrementScore(
              logicScoreQuiz.calculationScore(getPointRight(), _counter));

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Congratulations(
                  score: totalScoreLevel3.toString(), time: _timer)));

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
            totalScoreLevel3 = logicScoreQuiz.totalScore();

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GameOverLevel3(
                      score: logicScoreQuiz.totalScore(),
                      time: _timer,
                      question: question,
                      rightAnswer: correctAnswer,
                    )));
          }
          logicScoreQuiz.resetScore();
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
          QuestionDescription(description: getQuestionDescription(), size: 3),
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
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: () {
                      checkAnswerWithMultipleAlternatives(getAlternativeA());
                    },
                    child: Text(
                      getAlternativeA(),
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NunitoSemibold',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
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
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: () {
                      checkAnswerWithMultipleAlternatives(getAlternativeB());
                    },
                    child: Text(
                      getAlternativeB(),
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NunitoSemibold',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
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
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: () {
                      checkAnswerWithMultipleAlternatives(getAlternativeC());
                    },
                    child: Text(
                      getAlternativeC(),
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NunitoSemibold',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
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
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: () {
                      checkAnswerWithMultipleAlternatives(getAlternativeD());
                    },
                    child: Text(
                      getAlternativeD(),
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'NunitoSemibold',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
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

  stateManagement(Level3State state) {
    Loading commonActions = Loading();

    switch (state) {
      case Level3State.start:
        return commonActions.start();
      case Level3State.loading:
        return commonActions.loading();
      case Level3State.success:
        return _success();
      case Level3State.error:
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
