import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/main.dart';
import 'package:m/screens/bnv/pages/profile/widgets/arrow.dart';
import 'package:m/screens/bnv/pages/profile/widgets/info.dart';
import 'package:m/screens/bnv/pages/profile/widgets/setting.dart';
import 'package:m/screens/bnv/pages/profile/widgets/user_info.dart';
import 'package:m/screens/out_bnv/language/logic.dart';
import 'package:m/screens/out_bnv/language/ui.dart';
import 'package:provider/provider.dart';

import '../logic.dart';
import '../model.dart';

class AlreadyLogedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var logic = Provider.of<ProfileLogic>(context);
    User user = logic.user;
    var localization = Localization.of(context).profile;
    LanguageLogic languageLogic = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        user == null
            ? MyFutureBuilder<Response<Map<String, dynamic>>>(
                request: logic.getProfileInfo,
                empty: Text('networdl'),
                serverError: Text('networdl'),
                networkError: Text('networdl'),
                fullResponse: (snapshot) {
                  return UserInfo(User.fromJson(snapshot.data['success']));
                },
                loading: SizedBox.shrink())
            : UserInfo(user),
        Padding(padding: EdgeInsets.only(top: screen.heightConverter(35))),
        SettingTile(localization[1],
            ArrowWithText(languageLogic.selectedLanguageName(context)), () {
          Navigator.pushNamed(context, Language.route);
        }),
        Padding(
          padding: EdgeInsets.only(
              top: screen.heightConverter(20),
              bottom: screen.heightConverter(50)),
          child: FlatButton(
            onPressed: logic.signOut,
            child: Text(localization[2]),
            color: Color(0xffF5F5F5),
            textColor: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}
// SettingTile('Currency', ArrowWithText('USD'), () {}),
// SettingTile(
//     'Currency', CupertinoSwitch(value: true, onChanged: (x) {}), () {}),
// SettingTile('Units', ArrowWithText('Imperial'), () {}),
// SettingTile('Privacy Policy', Arrow(), () {}),
