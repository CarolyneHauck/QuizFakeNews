import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Middle extends StatelessWidget {
  final String score;

  Middle({required this.score});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.blueGrey,
        ),
        child: Column(
          children: [
            SizedBox(height: 30.0),
            Text(
              'VOCÊ ACERTOU TODAS AS QUESTÕES\n\n' +
                  'TOTAL DE PONTOS: ' +
                  score,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontFamily: 'Medium',
                  fontSize: 20),
            ),
            SizedBox(height: 20.0),
            Material(
              color: Colors.blueGrey,
              child: IconButton(
                icon: Icon(Icons.share),
                iconSize: 50,
                onPressed: () {
                  Share.share(
                      'Acertei todas as questões do jogo CheckIsso! e fiz um total de ' +
                          score +
                          'pontos, seja um perito em identificar Fake News também! Faça download do app!');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
