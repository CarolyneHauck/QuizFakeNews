import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_fake_news/controller/ranking1_controller.dart';
import 'package:quiz_fake_news/models/ranking.dart';
import 'package:quiz_fake_news/pages/common_actions.dart';
import 'package:quiz_fake_news/pages/levels/classic_question_with_image_quizzler.dart';
import 'package:quiz_fake_news/repositories/ranking_repository.dart';
import 'package:quiz_fake_news/widgets/middle_congrulations.dart';

RankingRepository ranking = RankingRepository();

class CongrulationNivel1 extends StatefulWidget {
  final String score;
  final String? email;
  final Timer time;

  CongrulationNivel1(
      {required this.score, required this.time, required this.email});

  @override
  _CongrulationNivel1State createState() =>
      _CongrulationNivel1State(score: score, time: time, email: email);
}

class _CongrulationNivel1State extends State<CongrulationNivel1> {
  final controller = Ranking1Controller();
  final String score;
  final String? email;
  final Timer time;

  _CongrulationNivel1State(
      {required this.score, required this.time, required this.email});

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  _success() {
    final List<Ranking> _rankingLevel1 = controller.ranking;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(flex: 2, child: Lottie.asset("animations/levelup.json")),
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

  stateManagement(Ranking1State state) {
    Loading commonActions = Loading();

    switch (state) {
      case Ranking1State.start:
        return commonActions.start();
      case Ranking1State.loading:
        return commonActions.loading();
      case Ranking1State.success:
        return _success();
      case Ranking1State.error:
        return commonActions.error();
      default:
        return commonActions.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
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
              _navigateToNextScreen(context, email);
            },
            shape: const StadiumBorder(),
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, String? email) {
    time.cancel();
    logicScoreQuiz.resetScore();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ClassicQuestionWithImagePage(email: email)));
  }
}
