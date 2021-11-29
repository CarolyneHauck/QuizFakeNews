import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_fake_news/models/ranking.dart';

class RankingRepository {
  final dio = Dio();

  void save(int totalScoreLevel1, String? email, String level) async {
    var collection = FirebaseFirestore.instance.collection(level);
    collection.doc().set({
      'name': email,
      'points': totalScoreLevel1,
    });
  }

  Future<List<Ranking>> fetchData(String level) async {
    List<Ranking> list = [];

    var data = await FirebaseFirestore.instance
        .collection(level)
        .orderBy('points')
        .limitToLast(3)
        .get();
    for (int i = 0; i < 3; i++) {
      Ranking model = Ranking(
          name: data.docs[i].data()['name'],
          points: data.docs[i].data()['points']);
      list.add(model);
    }
    return list;
  }
}
