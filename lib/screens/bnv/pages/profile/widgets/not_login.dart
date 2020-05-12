import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/auth/ui/login.dart';
import 'package:m/screens/out_bnv/auth/ui/register.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class NotLoginYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var themeData = Theme.of(context);
    var logic = Provider.of<ProfileLogic>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.lock,
          color: Colors.red,
          size: screen.heightConverter(100),
        ),
        Padding(
          padding: EdgeInsets.only(top: screen.heightConverter(120)),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, SignUp.route);
          },
          child: Text('SignUp'),
          color: themeData.accentColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: screen.heightConverter(15)),
        ),
        FlatButton(
          onPressed: () async {
            logic.user = await Navigator.pushNamed(context, Login.route);
          },
          child: Text('Login'),
          color: themeData.accentColor,
        )
      ],
    );
  }
}
/*
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: screen.widthConverter(10))),
            Text(
              'You Are not Login yet !',
              style: textTheme.display1,
            ),
          ],
        ),

*/
