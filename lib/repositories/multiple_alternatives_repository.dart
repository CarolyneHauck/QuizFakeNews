import 'package:dio/dio.dart';
import 'package:quiz_fake_news/models/types_questions/multiple_alternatives.dart';

class MultipleAlternativesRepository {
  final dio = Dio();

  final url =
      'https://fake-news-quiz-8bd80.firebaseio.com/multiple_alternatives.json';

  Future<List<MultipleAlternative>> fetchMultipleAlternatives() async {
    final response = await dio.get(url);
    final list = response.data as List;

    List<MultipleAlternative> multipleAlternativesQuestions = [];
    for (var json in list) {
      final multipleAlternativesQuestion = MultipleAlternative.fromJson(json);
      multipleAlternativesQuestions.add(multipleAlternativesQuestion);
    }

    return multipleAlternativesQuestions;
  }
}
