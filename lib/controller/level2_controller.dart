import 'package:flutter/material.dart';
import 'package:quiz_fake_news/models/types_questions/classic_with_image.dart';
import 'package:quiz_fake_news/repositories/classic_with_image_repository.dart';

class Level2Controller {
  List<ClassicQuestionWithImage> classicQuestionWithImage = [];
  final repository = ClassicQuestionWithImageRepository();
  final state = ValueNotifier<Level2State>(Level2State.start);

  Future startLevel2() async {
    state.value = Level2State.loading;
    try {
      classicQuestionWithImage =
          await repository.fetchClassicQuestionWithImage();
      state.value = Level2State.success;
    } catch (e) {
      state.value = Level2State.error;
    }
  }
}

enum Level2State { start, loading, success, error }
