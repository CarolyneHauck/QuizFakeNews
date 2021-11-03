import 'package:flutter/material.dart';
import 'package:quiz_fake_news/models/types_questions/multiple_alternatives.dart';
import 'package:quiz_fake_news/repositories/multiple_alternatives_repository.dart';

class Level3Controller {
  List<MultipleAlternative> multipleAlternatives = [];
  final repository = MultipleAlternativesRepository();
  final state = ValueNotifier<Level3State>(Level3State.start);

  Future startLevel3() async {
    state.value = Level3State.loading;
    try {
      multipleAlternatives = await repository.fetchMultipleAlternatives();
      state.value = Level3State.success;
    } catch (e) {
      state.value = Level3State.error;
    }
  }
}

enum Level3State { start, loading, success, error }
