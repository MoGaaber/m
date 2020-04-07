import 'package:flutter/material.dart';
import 'package:m/forget.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class LanguageSelect extends StatelessWidget {
  static const route = '/language';
  LanguageSelect();

  @override
  Widget build(BuildContext context) {
    return ListWithTitle(
        'Language', [for (var i = 0; i < 2; i++) LanguageTile()]);
  }
}

class LanguageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of<Screen>(context);

    return Column(
      children: <Widget>[
        ListTile(
            trailing: Icon(
              Icons.check,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: screen.heightConverter(10)),
            title: Text(
              'Arabic',
            )),
        Divider(
          height: 0,
          color: Color(0xff91919D).withOpacity(0.2),
        )
      ],
    );
  }
}
