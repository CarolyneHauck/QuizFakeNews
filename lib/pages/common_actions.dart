import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading {
  start() {
    return Center(child: CircularProgressIndicator());
  }

  loading() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(flex: 1, child: Lottie.asset("animations/loading.json")),
        ],
      ),
    );
  }

  _error() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(flex: 1, child: Lottie.asset("animations/error.json")),
        ],
      ),
    );
  }
}
