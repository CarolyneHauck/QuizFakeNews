import 'package:flutter/material.dart';
import 'package:quiz_fake_news/logic/score.dart';
import 'package:quiz_fake_news/pages/rules.dart';

import 'levels/classic_question_quizzler.dart';

LogicScoreQuiz logicScoreQuiz = LogicScoreQuiz();

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 30.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/info_screen.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: RawMaterialButton(
                              fillColor: Colors.blueGrey,
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      "VERIFIQUE AS REGRAS!",
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Rules()));
                              },
                              shape: const StadiumBorder(),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(2.0)),
                          SizedBox(
                            width: double.infinity,
                            child: RawMaterialButton(
                              fillColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    Text(
                                      "JOGUE AGORA!",
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
                                logicScoreQuiz.resetScore();
                                _navigateToNextScreen(context);
                              },
                              shape: const StadiumBorder(),
                            ),
                          ), // ElevatedButton
                        ], // <Widget>[]
                      ), // Column
                    ), // Cente
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PageHome(email: 'carol@gmail.com')));
  }
}
