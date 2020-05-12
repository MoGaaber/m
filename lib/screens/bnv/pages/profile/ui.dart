import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/main.dart';
import 'package:m/screens/bnv/pages/profile/widgets/already_login.dart';
import 'package:m/screens/bnv/pages/profile/widgets/not_login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class ProfileRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileLogic(),
      child: Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var themeData = Theme.of(context);
    var textTheme = themeData.textTheme;
    var logic = Provider.of<ProfileLogic>(context);
    Geolocator().getCurrentPosition().then((x) {
      print(x.latitude);
    });
    return SafeArea(
        child: Scaffold(
      body: RefreshIndicator(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: screen.widthConverter(20.5)),
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screen.heightConverter(25)),
              child: Text(
                Localization.of(context).profile[0],
                style: textTheme.display2,
              ),
            ),
            sharedPreferences?.getBool('isLoggedIn') ?? false
                ? AlreadyLogedIn()
                : NotLoginYet()
          ],
        ),
        onRefresh: logic.refresh,
      ),
    ));
    ;
  }
}
