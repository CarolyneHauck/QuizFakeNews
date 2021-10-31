import 'package:flutter/material.dart';

class QuestionDescription extends StatelessWidget {
  QuestionDescription({required this.description, required this.size});

  final String description;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: size,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(16.0),
            color: Colors.blueGrey,
          ),
          child: new Center(
            child: new Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'NunitoSemibold',
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
