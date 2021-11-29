import 'package:flutter/material.dart';
import 'package:quiz_fake_news/models/ranking.dart';
import 'package:quiz_fake_news/repositories/ranking_repository.dart';

class Ranking2Controller {
  List<Ranking> ranking2 = [];
  final repository = RankingRepository();
  final state = ValueNotifier<Ranking2State>(Ranking2State.start);

  Future start() async {
    state.value = Ranking2State.loading;
    try {
      ranking2 = await repository.fetchData('level2');
      state.value = Ranking2State.success;
    } catch (e) {
      state.value = Ranking2State.error;
    }
  }
}

enum Ranking2State { start, loading, success, error }
