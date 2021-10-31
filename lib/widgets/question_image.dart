import 'package:flutter/material.dart';
import 'package:quiz_fake_news/pages/classic_with_image_quizzler.dart';

class QuestionImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(16.0),
            color: Colors.blueGrey,
          ),
          child: classicQuestionWithImageQuiz.getImage(),
        ),
      ),
    );
  }
}
