import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/main.dart';

class LanguageTileModel {
  String name;
  String localCode;

  LanguageTileModel(this.name, this.localCode);

  bool isSelected(BuildContext context) =>
      Localization.of(context).locale.languageCode == localCode ? true : false;

  Color checkMarkColor(BuildContext context) {
    var theme = Theme.of(context);
    if (isSelected(context)) {
      return theme.accentColor;
    } else {
      return theme.dividerColor;
    }
  }
}

class Language {
  String name;
  Language(this.name);
}
/*


  static void toCastedList(Map<String, dynamic> json, BuildContext context) {
    var newList = List<LanguageTileModel>();
    var locale = sharedPreferences.getString('languageCode') ??
        Localization.of(context).locale.languageCode;
    json.forEach((k, v) {
      print(locale);
      
      newList.add(LanguageTileModel(v, k, locale == k ? true : false));
    });

    castedList = newList;
  }

*/
