import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/localization/localization.dart';
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
    var localization = Localization.of(context).auth;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(20.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Spacer(
            flex: 3,
          ),
          Icon(
            FontAwesomeIcons.userLock,
            color: Colors.black,
            size: screen.heightConverter(100),
          ),
          Spacer(
            flex: 4,
          ),
          FlatButton(
            onPressed: () async {
           var x=    await Navigator.pushNamed(context, SignUp.route);
           logic.notifyListeners();
           },
            child: Text(localization[1]),
            color: themeData.accentColor,
          ),
          Spacer(
            flex: 1,
          ),
          FlatButton(
            onPressed: () async {
              logic.user = await Navigator.pushNamed(context, Login.route);
              logic.notifyListeners();
            },
            child: Text(localization[0]),
            color: themeData.accentColor,
          ),
          Spacer(
            flex: 4,
          ),
        ],
      ),
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
