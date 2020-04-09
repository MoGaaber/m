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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('did');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              'assets/logo.png',
              fit: BoxFit.fitWidth,
              width: screen.widthConverter(216),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: screen.heightConverter(20))),
          SizedBox(
            height: screen.heightConverter(10),
            width: screen.widthConverter(50),
            child: Rive(
              filename: 'assets/loadd.flr',
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
// Image.asset(
//           'assets/logo.png',
//           fit: BoxFit.fitHeight,
//           height: 80,
//           width: 300,
//         ),
