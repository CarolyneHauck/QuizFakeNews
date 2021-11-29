import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_fake_news/controller/ranking3_controller.dart';
import 'package:quiz_fake_news/models/ranking.dart';
import 'package:quiz_fake_news/pages/common_actions.dart';
import 'package:quiz_fake_news/pages/start_game.dart';
import 'package:quiz_fake_news/repositories/ranking_repository.dart';
import 'package:quiz_fake_news/widgets/middle_congrulations.dart';

RankingRepository ranking = RankingRepository();

class CongratulationsNivelFinal extends StatefulWidget {
  final String score;
  final String? email;
  final Timer time;

  CongratulationsNivelFinal(
      {required this.score, required this.time, required this.email});

  @override
  _CongrulationNivel3State createState() =>
      _CongrulationNivel3State(score: score, time: time, email: email);
}

class _CongrulationNivel3State extends State<CongratulationsNivelFinal> {
  final controllerRanking3 = Ranking3Controller();
  final String score;
  final String? email;
  final Timer time;

  _CongrulationNivel3State(
      {required this.score, required this.time, required this.email});

  @override
  void initState() {
    super.initState();
    controllerRanking3.start();
  }

  _success() {
    final List<Ranking> _rankingLevel1 = controllerRanking3.ranking3;

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
              flex: 2, child: Lottie.asset("animations/congratulations.json")),
          Expanded(
            flex: 4,
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                color: Colors.blueGrey,
              ),
              child: Center(
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      "RANKING",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Medium',
                        fontSize: 20.0,
                      ),
                    )),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final item = _rankingLevel1[index];
                        return Center(
                          child: ListTile(
                            title: Center(
                                child: Text(
                              item.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Medium',
                                fontSize: 20.0,
                              ),
                            )),
                            subtitle: Center(
                                child: Text(
                              item.points.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Medium',
                                fontSize: 18.0,
                              ),
                            )),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(width: 5.0),
          ),
          Middle(score: score),
          StartAgain(time: time, email: email),
        ],
      ),
    );
  }

  stateManagement(Ranking3State state) {
    Loading commonActions = Loading();

    switch (state) {
      case Ranking3State.start:
        return commonActions.start();
      case Ranking3State.loading:
        return commonActions.loading();
      case Ranking3State.success:
        return _success();
      case Ranking3State.error:
        return commonActions.error();
      default:
        return commonActions.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controllerRanking3.state,
        builder: (context, child) {
          return stateManagement(controllerRanking3.state.value);
        },
      ),
    );
  }
}

class StartAgain extends StatelessWidget {
  final Timer time;
  final String? email;

  StartAgain({required this.time, required this.email});

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
