import 'package:flutter/material.dart';
import 'package:m/forget.dart';
import 'package:m/logic.dart';

class SignUp extends StatelessWidget {
  static const route = '/signup';

  @override
  Widget build(BuildContext context) {
    return UserRegistirationRoot(
        'Create new account',
        Column(
          children: <Widget>[
            MyTextField('Name'),
            MyTextField('Email Address'),
            MyTextField('Password'),
          ],
        ),
        'Sign up',
        () {});
  }
}
