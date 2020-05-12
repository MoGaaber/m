import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BnvIconModel {
  IconData icon;
  bool selected;
  Widget body;

  Color color(BuildContext context) {
    if (selected) {
      return Color(0xff005C15);
    } else {
      return Color(0xff577584);
    }
  }

  BnvIconModel(this.icon, this.body, {this.selected = false});
}
