import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/main.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

class LanguageLogic extends ChangeNotifier {
  BuildContext context;
  CompleteElementModel horizontalListElement;
  List<LanguageTileModel> languages = [
    LanguageTileModel(
      'English',
      'en',
    ),
    LanguageTileModel(
      'العربيه',
      'ar',
    )
  ];
  String selectedLanguageName(BuildContext context) =>
      languages[languages.indexWhere((language) =>
              language.localCode ==
              Localization.of(context).locale.languageCode)]
          .name;

  String myLocalCode(BuildContext context) =>
      sharedPreferences.getString('languageCode') ??
      Localization.of(context).locale.languageCode;

  Future<void> selectLanguage(BuildContext context, int index) async {
    await sharedPreferences.setString(
        'languageCode', languages[index].localCode);

    notifyListeners();
  }
}
/*
    var progressDialog = ProgressDialog(
      context,
      isDismissible: false,
    );

    // languages[myLanguageIndex].selected = false;
    // progressDialog.show();
    // progressDialog.hide();
    // languages[index].selected = true;
    // myLanguageIndex = index;

    // languages[languages.indexWhere((element) {
    //   return element.localCode == sharedPreferences.getString('languageCode') ??
    //       Localization.of(context).locale.languageCode;
    // })]
    //     .selected = true;

*/
