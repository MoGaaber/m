import 'package:flutter/cupertino.dart';

import 'localization/localization.dart';

class Methods {
  static int customlanguageIndex(List translations, String languageCode) {
    return translations.indexWhere((element) {
      return element['locale'] == languageCode;
    });
  }

  static int languageIndex(BuildContext context, List translations) {
    return translations.indexWhere((element) {
      return element['locale'] == Localization.of(context).locale.languageCode;
    });
  }
}
