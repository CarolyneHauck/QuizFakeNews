import 'package:dio/dio.dart';
import 'package:quiz_fake_news/models/types_questions/classic_question.dart';

class ClassicQuestionRepository {
  final dio = Dio();

  final url =
      'https://fake-news-quiz-8bd69-default-rtdb.firebaseio.com/classicQuestion.json';

  Future<List<ClassicQuestion>> fetchClassicQuestion() async {
    final response = await dio.get(url);
    final list = response.data as List;

    List<ClassicQuestion> classicQuestions = [];
    for (var json in list) {
      final classicQuestion = ClassicQuestion.fromJson(json);
      classicQuestions.add(classicQuestion);
    }

    return classicQuestions;
  }
}
