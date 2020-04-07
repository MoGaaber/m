import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static const route = '/splash';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.fitHeight,
          height: 80,
          width: 300,
        ),
      ),
    ));
  }
}
