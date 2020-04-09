import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:m/bnv.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Splash extends StatefulWidget {
  static const route = '/splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  @override
  Widget build(BuildContext context) {
    print('build');
    Screen screen = Provider.of(context);
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              width: screen.widthConverter(214),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: screen.heightConverter(20))),
          SizedBox(
            height: screen.heightConverter(10),
            width: screen.widthConverter(50),
            child: Rive(
              filename: 'assets/flare/load.flr',
              animation: 'Untitled',
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Bnv.route);
    });
  }
}
