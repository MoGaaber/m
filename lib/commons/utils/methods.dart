import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import 'localization/localization.dart';

class Methods {
  BuildContext context;
  Methods(this.context);
  static int customlanguageIndex(List translations, String languageCode) {
    return translations.indexWhere((element) {
      return element['locale'] == languageCode;
    });
  }

  int languageIndex(List translations) {
    return translations.indexWhere((element) {
      return element['locale'] == Localization.of(context).locale.languageCode;
    });
  }

  ProgressDialog get progressDialog =>
      ProgressDialog(context, isDismissible: true)
        ..style(
            message: '',
            borderRadius: Provider.of<Screen>(context, listen: false)
                .aspectRatioConverter(5),
            progressWidget: CircularProgressIndicator());
  Future<void> showProgressDialog() async => await progressDialog.show();
  Future<void> hideProgressDialog() async => await progressDialog.hide();
}
