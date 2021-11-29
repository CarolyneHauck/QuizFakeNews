import 'package:flutter/material.dart';
import 'package:quiz_fake_news/models/ranking.dart';
import 'package:quiz_fake_news/repositories/ranking_repository.dart';

class Ranking1Controller {
  List<Ranking> ranking = [];
  final repository = Ranking1Repository();
  final state = ValueNotifier<Ranking1State>(Ranking1State.start);

  Future start() async {
    state.value = Ranking1State.loading;
    try {
      ranking = await repository.fetchData();
      state.value = Ranking1State.success;
    } catch (e) {
      state.value = Ranking1State.error;
    }
  }
}

enum Ranking1State { start, loading, success, error }
