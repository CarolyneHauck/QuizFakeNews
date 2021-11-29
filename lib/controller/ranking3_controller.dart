import 'package:flutter/material.dart';
import 'package:quiz_fake_news/models/ranking.dart';
import 'package:quiz_fake_news/repositories/ranking_repository.dart';

class Ranking3Controller {
  List<Ranking> ranking3 = [];
  final repository = RankingRepository();
  final state = ValueNotifier<Ranking3State>(Ranking3State.start);

  Future start() async {
    state.value = Ranking3State.loading;
    try {
      ranking3 = await repository.fetchData('level3');
      state.value = Ranking3State.success;
    } catch (e) {
      state.value = Ranking3State.error;
    }
  }
}

enum Ranking3State { start, loading, success, error }
