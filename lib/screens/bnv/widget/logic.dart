import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/screens/bnv/pages/profile/ui.dart';
import 'package:m/screens/bnv/pages/search/ui.dart';
import 'package:m/screens/bnv/pages/trips/ui.dart';

import 'model.dart';

class BnvLogic with ChangeNotifier {
  var pageController = PageController();
  int oldIndex = 0;
  int currentIndex = 0;
  static String serachLanguage;

  Future<bool> realNetConnection;

  var bnv = [
    BnvIconModel(FontAwesomeIcons.suitcaseRolling, TripsRoot(), selected: true),
    BnvIconModel(
      FontAwesomeIcons.search,
      SearchRoot(),
    ),
    BnvIconModel(
      FontAwesomeIcons.user,
      ProfileRoot(),
    )
  ];
  BnvLogic() {
    realNetConnection = getrealNetConnection;
  }

  Future<bool> get getrealNetConnection async =>
      await DataConnectionChecker().hasConnection;

  void refetchRealNetConnection() {
    realNetConnection = getrealNetConnection;
    notifyListeners();
  }

  static void restoreLanguage() {
    if (CompleteElementModel.languageCode !=
        CompleteElementModel.deviceLanguageCode)
      CompleteElementModel.languageCode =
          CompleteElementModel.deviceLanguageCode;
  }

  static List actions = [
    restoreLanguage,
    () {
      if (CompleteElementModel.languageCode != serachLanguage)
        CompleteElementModel.languageCode = serachLanguage;
    },
    () {}
  ];
  void onTap(int i, BuildContext context) {
    actions[i]();
    pageController.animateToPage(i,
        duration: Duration(milliseconds: 400), curve: Curves.easeInSine);
    changeActiveIcon(i);
    notifyListeners();
  }

  void toSearchPage() {
    pageController.jumpToPage(1);
    changeActiveIcon(1);
    notifyListeners();
  }

  void changeActiveIcon(int i) {
    bnv[currentIndex].selected = false;
    this.currentIndex = i;
    bnv[currentIndex].selected = true;
  }
}
