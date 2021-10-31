import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_fake_news/pages/classic_quizzler.dart';
import 'package:quiz_fake_news/pages/game_over.dart';

class StopQuestion extends StatelessWidget {
  final int pointsStop;
  final Timer time;

  StopQuestion({required this.pointsStop, required this.time});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(
          width: 2.0,
          color: Colors.black,
        ),
      ),
      child: Text(
        pointsStop.toString() + '\nPARAR',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Medium',
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GameOver(
                score: logicScoreQuiz.totalScore() + 3000, time: time)));
      },
    );
  }
}
