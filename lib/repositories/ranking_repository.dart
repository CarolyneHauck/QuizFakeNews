import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_fake_news/models/ranking.dart';

class Ranking1Repository {
  final dio = Dio();
  List<Ranking> list = [];

  void save(int totalScoreLevel1, String? email) async {
    var collection = FirebaseFirestore.instance.collection('leve1');
    collection.doc().set({
      'name': email,
      'points': totalScoreLevel1,
    });
  }

  Future<List<Ranking>> fetchData() async {
    var data = await FirebaseFirestore.instance
        .collection('leve1')
        .orderBy('points')
        .get();
    for (int i = 0; i < data.docs.length; i++) {
      Ranking model = Ranking(
          name: data.docs[i].data()['name'],
          points: data.docs[i].data()['points']);
      list.add(model);
    }
    return list;
  }
}
