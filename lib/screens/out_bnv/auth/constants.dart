import 'package:flutter/cupertino.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';

class AuthConstants {
  EdgeInsetsGeometry contentPaddingField;
  double left;
  double right;
  double top;
  AuthConstants(BuildContext context) {
    var localization = Localization.of(context).locale.languageCode;
    Screen screen = Provider.of(context);
    top = screen.heightConverter(15);
    right = localization == 'en'
        ? screen.widthConverter(40)
        : screen.widthConverter(10);
    left = localization == 'en'
        ? screen.widthConverter(10)
        : screen.widthConverter(40);
    this.contentPaddingField = EdgeInsets.symmetric(
        horizontal: screen.widthConverter(10),
        vertical: screen.heightConverter(15));
  }
}
/*
    this.contentPaddingField = EdgeInsets.fromLTRB(
        localization == 'en' ? 0 : screen.widthConverter(40),
        screen.heightConverter(14),
        localization == 'en'
            ? screen.widthConverter(0)
            : screen.widthConverter(10),
        screen.heightConverter(14));
*/
