import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/bnv/pages/trips/models/grid_list.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:m/screens/out_bnv/more/model.dart';
import '../../../constants/constants.dart';

enum FutureBuilderStatus { waiting, done, failed }

class MoreLogic extends ChangeNotifier {
  var searchController = TextEditingController();
  GridViewModel gridViewModel;
  FutureBuilderStatus futureBuilderStatus;
  int id;
  String firstLetter;

  var searchList = List<CompleteElementModel>();
  Future<Response<Map<String, dynamic>>> request;

  Future<Response<Map<String, dynamic>>> getRequest() async {
    return await Dio().get(ApisUrls.more + '/$id');
  }

  void onChanged(BuildContext context, String text) {
    searchList.clear();
    if (text.isNotEmpty) {
      if (firstLetter != text[0]) {
        var languageCode = Constants.checkLanguage(text.toLowerCase());
        if (languageCode != Localization.of(context).locale.languageCode) {
          CompleteElementModel.languageCode = languageCode;
        } else {
          CompleteElementModel.languageCode =
              Localization.of(context).locale.languageCode;
        }
      }
      firstLetter = text[0];

      for (var i = 0; i < gridViewModel.castedResponse.length; i++) {
        if (gridViewModel.castedResponse[i].getTitle
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchList.add(gridViewModel.castedResponse[i]);
        }
      }
    }
    notifyListeners();
  }

  Future<void> refresh() {
    request = null;
    notifyListeners();
    return request = getRequest();
  }
}
