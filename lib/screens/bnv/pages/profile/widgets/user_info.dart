import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:provider/provider.dart';

import '../logic.dart';
import '../model.dart';
import 'info.dart';

class UserInfo extends StatelessWidget {
  Widget image;
  Widget name;
  Widget email;
  UserInfo({this.image, this.email, this.name});
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var themeData = Theme.of(context);
    var logic = Provider.of<ProfileLogic>(context);
    var textTheme = themeData.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            height: screen.heightConverter(100),
            width: screen.widthConverter(90),
            child: image),
        Padding(
            padding: EdgeInsets.only(
          left: screen.widthConverter(11),
        )),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screen.heightConverter(5)),
                child: name,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screen.heightConverter(5)),
                child: email,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class UserInfoLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
