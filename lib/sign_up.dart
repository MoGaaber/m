import 'package:flutter/material.dart';
import 'package:m/bnv.dart';
import 'package:m/forget.dart';
import 'package:m/logic.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  static const route = '/signup';

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: screen.widthConverter(20.5)),
                  children: <Widget>[
                    Text(
                      'Create new account',
                      style: textTheme.display2,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: screen.heightConverter(23))),
                    MyTextField('Name'),
                    MyTextField('Email Address'),
                    MyTextField('Password'),
                    Padding(
                        child: FlatButton(
                          onPressed: () {},
                          child: Text('Sign up'),
                          color: themeData.accentColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: screen.heightConverter(33.5)))
                  ]),
            )));
  }
}
