import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/language/logic.dart';
import 'package:m/screens/out_bnv/language/model.dart';
import 'package:provider/provider.dart';
import 'language_tile.dart';

Map<String, dynamic> test;

class Language extends StatelessWidget {
  static const route = '/language';

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;
    Screen screen = Provider.of<Screen>(context, listen: false);
    LanguageLogic languageLogic =
        Provider.of<LanguageLogic>(context, listen: false);
    print(languageLogic.languages[1].isSelected);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screen.widthConverter(10),
              vertical: screen.heightConverter(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Localization.of(context).language[0],
                style: textTheme.display2,
              ),
              Padding(
                  padding: EdgeInsets.only(top: screen.heightConverter(10))),
              Expanded(
                  child: ListView.separated(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) =>
                    LanguageTile(index),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 0,
                  color: Color(0xff91919D).withOpacity(0.2),
                ),
              )),
            ],
          )),
    );
  }
}
