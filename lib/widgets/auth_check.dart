import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_fake_news/pages/levels/classic_question_quizzler.dart';
import 'package:quiz_fake_news/pages/login_page.dart';
import 'package:quiz_fake_news/services/auth_service.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginPage();
    else
      return PageHome();
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
