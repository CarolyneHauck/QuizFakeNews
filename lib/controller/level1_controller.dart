import 'package:flutter/material.dart';
import 'package:quiz_fake_news/models/types_questions/classic_question.dart';
import 'package:quiz_fake_news/repositories/classic_question_repository.dart';

class Level1Controller {
  List<ClassicQuestion> todos = [];
  final repository = ClassicQuestionRepository();
  final state = ValueNotifier<Level1State>(Level1State.start);

  Future start() async {
    state.value = Level1State.loading;
    try {
      todos = await repository.fetchClassicQuestion();
      state.value = Level1State.success;
    } catch (e) {
      state.value = Level1State.error;
    }
  }
}

enum Level1State { start, loading, success, error }
