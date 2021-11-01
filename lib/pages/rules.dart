import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_fake_news/pages/start_game.dart';

class Rules extends StatelessWidget {
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
          Expanded(flex: 5, child: Lottie.asset("animations/news.json")),
          Expanded(
            flex: 4,
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                color: Colors.blueGrey,
              ),
              child: Center(
                child: Text(
                  'REGRAS:\n\n 1 - Se errar alguma questao o jogo acaba.\n 2 - Quanto mais rápido responder mais pontos ira ganhar.\n 3 - Apenas um PULAR e ACERTAR por nível.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontFamily: 'Medium',
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          StartAgain(),
        ],
      ),
    );
  }
}

class StartAgain extends StatelessWidget {
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
                    "VOLTAR!",
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Start()));
  }
}
