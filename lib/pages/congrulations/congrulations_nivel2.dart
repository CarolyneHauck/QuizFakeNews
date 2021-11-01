import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../multiple_alternatives_quizzler.dart';

class CongratulationsNivel2 extends StatelessWidget {
  final String score;
  final Timer time;

  CongratulationsNivel2({required this.score, required this.time});

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
          Expanded(flex: 5, child: Lottie.asset("animations/levelup.json")),
          Middle(score: score),
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
                    "PROXIMO NÍVEL!",
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

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => QuizzlerWithMultipleAlternatives()));
  }
}

class Middle extends StatelessWidget {
  final String score;

  Middle({required this.score});

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
            'VOCÊ ACERTOU TODAS AS QUESTÕES\n\n' + 'TOTAL DE PONTOS: ' + score,
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontFamily: 'Medium',
                fontSize: 24),
          ),
        ),
      ),
    );
  }
}
