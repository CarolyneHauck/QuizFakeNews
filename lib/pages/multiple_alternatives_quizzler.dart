import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/logic/logic_multiple_alternatives.dart';
import 'package:quiz_fake_news/pages/time_is_up.dart';
import 'package:quiz_fake_news/widgets/counter_time.dart';
import 'package:quiz_fake_news/widgets/question_description.dart';
import 'package:quiz_fake_news/widgets/stop_question.dart';

import 'classic_quizzler.dart';
import 'congrulations/congrulations_final.dart';
import 'game_over.dart';

LogicMultipleAlternativesQuiz multipleAlternativesQuiz =
    LogicMultipleAlternativesQuiz();

class QuizzlerWithMultipleAlternatives extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizzlerWithMultipleAlternativePage(),
        ),
      ),
    );
  }
}

class QuizzlerWithMultipleAlternativePage extends StatefulWidget {
  @override
  _QuizWithMultipleAlternativePageState createState() =>
      _QuizWithMultipleAlternativePageState();
}

class _QuizWithMultipleAlternativePageState
    extends State<QuizzlerWithMultipleAlternativePage> {
  bool status = true;
  bool statusRight = false;

  int _counter = 0;
  late Timer _timer;
  int finalScore = 0;

  void _startTimer() {
    _counter = multipleAlternativesQuiz.getCounter();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        if (multipleAlternativesQuiz.isFinished() == false) {
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
      status = false;
    });
  }

  void enableButtonSkip() {
    setState(() {
      status = false;
    });
  }

  void checkAnswerWithMultipleAlternatives(String userPickedAnswer) {
    String correctAnswer = multipleAlternativesQuiz.getQuestionAnswer();

    setState(() {
      if (multipleAlternativesQuiz.isFinished() == true) {
        logicScoreQuiz
            .incrementScore(multipleAlternativesQuiz.getPointAnswer());

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Congratulations(
                score: logicScoreQuiz.totalScore().toString(), time: _timer)));

        _timer.cancel();
        multipleAlternativesQuiz.reset();
      } else {
        if (userPickedAnswer == correctAnswer) {
          if (classicQuestionQuiz.secondQuestion()) {
            enableButtonSkip();
          }
          _timer.cancel();
          logicScoreQuiz
              .incrementScore(multipleAlternativesQuiz.getPointAnswer());
        } else {
          _timer.cancel();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  GameOver(score: logicScoreQuiz.totalScore(), time: _timer)));
        }

        _timer.cancel();
        _startTimer();
        multipleAlternativesQuiz.nextQuestion();
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (multipleAlternativesQuiz.isFinished() == true) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Congratulations(
                score: logicScoreQuiz.totalScore().toString(), time: _timer)));

        multipleAlternativesQuiz.reset();
      } else {
        _timer.cancel();
        _startTimer();
        multipleAlternativesQuiz.nextQuestion();
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
          QuestionDescription(
            description: multipleAlternativesQuiz.getQuestionDescription(),
            size: 2,
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
                      checkAnswerWithMultipleAlternatives(
                          multipleAlternativesQuiz.getAlternativeA());
                    },
                    child: Text(
                      multipleAlternativesQuiz.getAlternativeA(),
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
                      checkAnswerWithMultipleAlternatives(
                          multipleAlternativesQuiz.getAlternativeB());
                    },
                    child: Text(
                      multipleAlternativesQuiz.getAlternativeB(),
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
                      checkAnswerWithMultipleAlternatives(
                          multipleAlternativesQuiz.getAlternativeC());
                    },
                    child: Text(
                      multipleAlternativesQuiz.getAlternativeC(),
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
                      checkAnswerWithMultipleAlternatives(
                          multipleAlternativesQuiz.getAlternativeD());
                    },
                    child: Text(
                      multipleAlternativesQuiz.getAlternativeD(),
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
                          multipleAlternativesQuiz.getPointSkip().toString() +
                          '\nPULAR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: statusRight
                        ? null
                        : () => whatToDoOnPressedSkip(time: _timer),
                  ),
                  StopQuestion(
                      pointsStop: multipleAlternativesQuiz.getPointStop(),
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
                      multipleAlternativesQuiz.getPointRight().toString() +
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
    logicScoreQuiz.decreaseScore(multipleAlternativesQuiz.getPointSkip());
    disableButtonSkip();
    nextQuestion();
  }

  void whatToDoOnPressedRight({required Timer time}) {
    time.cancel();
    logicScoreQuiz.incrementScore(multipleAlternativesQuiz.getPointRight());
    setState(() {
      statusRight = true;
    });
    nextQuestion();
  }
}
