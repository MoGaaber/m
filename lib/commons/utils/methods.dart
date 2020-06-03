import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
      ProgressDialog(context, isDismissible: false)
        ..style(
            message: Localization.of(context).globals[0],
            progressWidget: Center(
                child: SizedBox(
              child: CircularProgressIndicator(),
              width: 40.w,
              height: 40.h,
            )),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h));
  Future<void> showProgressDialog() async => await progressDialog.show();
  Future<void> hideProgressDialog() async => await progressDialog.hide();
  static void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
