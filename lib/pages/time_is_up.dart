import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/pages/start_game.dart';
import 'package:lottie/lottie.dart';

class TimeIsUp extends StatelessWidget {
  final int score;
  final Timer time;

  TimeIsUp({required this.score, required this.time});

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
          Expanded(flex: 5, child: Lottie.asset("animations/timesup.json")),
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
                    "JOGAR NOVAMENTE!",
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
    logicScoreQuiz.resetScore();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Start()));
  }
}

class Score extends StatelessWidget {
  final int score;

  Score({required this.score});

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
