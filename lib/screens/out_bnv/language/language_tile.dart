import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/language/logic.dart';
import 'package:m/screens/out_bnv/language/model.dart';
import 'package:provider/provider.dart';

class LanguageTile extends StatelessWidget {
  final int index;
  LanguageTile(this.index);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of<Screen>(context);
    LanguageLogic languageLogic = Provider.of(context, listen: false);
    var language = languageLogic.languages[index];
    return ListTile(
        onTap: () {
          languageLogic.selectLanguage(context, index);
        },
        trailing: Icon(
          Icons.check,
          size: 30,
          color: language.checkMarkColor(context),
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: screen.heightConverter(10)),
        title: Text(
          language.name,
        ));
  }
}
