import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_fake_news/pages/start_game.dart';

class GameOverLevel3 extends StatelessWidget {
  final String rightAnswer;
  final String question;
  final int score;
  final Timer time;

  GameOverLevel3(
      {required this.score,
      required this.time,
      required this.rightAnswer,
      required this.question});

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
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox(width: 5.0),
          ),
          Expanded(flex: 3, child: Lottie.asset("animations/gameover.json")),
          Answer(rightAnswer: rightAnswer, question: question),
          Expanded(
            flex: 1,
            child: SizedBox(width: 5.0),
          ),
          Score(score: score),
          StartAgain(time: time),
        ],
      ),
    );
  }
}

class StartAgain extends StatelessWidget {
  final Timer time;

  StartAgain({required this.time});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(10.0),
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
                    "SAIR!",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Medium',
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              _navigateToNextScreen(context);
            },
            shape: const StadiumBorder(),
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    time.cancel();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Start()));
  }
}

class Answer extends StatelessWidget {
  final String rightAnswer;
  final String question;

  Answer({required this.rightAnswer, required this.question});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.blueGrey,
        ),
        child: Center(
          child: Text(
            'A Resposta Correta da Questão:\n' +
                '\"' +
                question +
                '\"' +
                '\n é ' +
                rightAnswer,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: 'Medium',
            ),
          ),
        ),
      ),
    );
  }
}

class Score extends StatelessWidget {
  final int score;

  Score({required this.score});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.blueGrey,
        ),
        child: Center(
          child: Text(
            'VOCÊ ACUMULOU\n' + score.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontFamily: 'Medium',
            ),
          ),
        ),
      ),
    );
  }
}
