import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/constants/constants.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:m/screens/bnv/widget/logic.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class SearchLogic with ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();

  String searchResultLanguageCode;
  SearchModel searchModel;
  bool get isEn => searchResultLanguageCode == 'en';
  Future<Response<Map<String, dynamic>>> getSearchResult;
  SearchLogic(BuildContext context) {
    searchResultLanguageCode = Localization.of(context).locale.languageCode;
  }
  void clearSearchField() {
    textEditingController.clear();
    notifyListeners();
  }

  void onChangeSearchText(BuildContext context, String input) async {
    Provider.of<BnvLogic>(context, listen: false);
    if (input.length == 1) {
      searchResultLanguageCode = Constants.checkLanguage(input);
      BnvLogic.serachLanguage = searchResultLanguageCode;
      CompleteElementModel.languageCode = searchResultLanguageCode;
    }

    if (await Connectivity().checkConnectivity() != ConnectivityResult.none &&
        await DataConnectionChecker().hasConnection) {
      print('hey i have network');
      getSearchResult = Dio().post(ApisUrls.searchAndFilter,
          data: FormData.fromMap({'title': input}));
    } else if (searchModel != null) {
      getSearchResult = Dio().post(ApisUrls.searchAndFilter,
          data: FormData.fromMap({'title': input}));
      searchModel = null;
    }
    notifyListeners();
  }

  void initializeData(BuildContext context) {
    // print(searchResultLanguageCode);
    // if (searchModel.searchResult[0].languageCode != searchResultLanguageCode) {
    //   print('iam called');

    //   searchModel.changeListLanguage(searchResultLanguageCode);
    // }
  }
}
/*
  var arabicLetters = [
    'أ',
    'ب',
    'ت',
    'ث',
    'ج',
    'ح',
    'خ',
    'د',
    'ذ',
    'ر',
    'ز',
    'س',
    'ش',
    'ص',
    'ض',
    'ط',
    'ظ',
    'ع',
    'غ',
    'ف',
    'ق',
    'ك',
    'ل',
    'م',
    'ن',
    'ه',
    'و',
    'ي',
    'ئ',
    'ء',
    'ؤ',
    'أ',
    'لا',
    'لأ',
    'لآ',
    'آ',
    'ذ'
  ];
*/
