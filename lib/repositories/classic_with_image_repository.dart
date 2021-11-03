import 'package:dio/dio.dart';
import 'package:quiz_fake_news/models/types_questions/classic_with_image.dart';

class ClassicQuestionWithImageRepository {
  final dio = Dio();

  final url =
      'https://fake-news-quiz-8bd70.firebaseio.com/classicQuestionWithImage.json';

  Future<List<ClassicQuestionWithImage>> fetchClassicQuestionWithImage() async {
    final response = await dio.get(url);
    final list = response.data as List;

    List<ClassicQuestionWithImage> classicQuestions = [];
    for (var json in list) {
      final classicQuestion = ClassicQuestionWithImage.fromJson(json);
      classicQuestions.add(classicQuestion);
    }

    return classicQuestions;
  }
}
