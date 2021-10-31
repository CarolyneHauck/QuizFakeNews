import 'package:flutter/material.dart';

class CounterPoints extends StatelessWidget {
  CounterPoints({required this.points});

  final String points;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(),
      ),
      child: new Text(
        'Pontos: ' + points,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'NunitoSemibold',
          fontSize: 22.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
