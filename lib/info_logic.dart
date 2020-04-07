import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m/bnv_icon.dart';

class InfoLogic with ChangeNotifier {
  List<BnvIconModel> bnvIcons = [
    BnvIconModel(Colors.red, Icons.access_alarm, () {}),
    BnvIconModel(Colors.red, Icons.access_alarm, () {}),
    BnvIconModel(Colors.red, Icons.access_alarm, () {}),
    BnvIconModel(Colors.red, Icons.access_alarm, () {})
  ];
}
