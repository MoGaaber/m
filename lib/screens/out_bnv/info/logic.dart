import 'package:flutter/foundation.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:m/screens/bnv/pages/trips/widgets/hiroz_list.dart';

class InfoLogic with ChangeNotifier {
  CompleteElementModel horizontalListElement;

  void toggleMorLess() {
    horizontalListElement.setToogleMoreLess();
    notifyListeners();
  }
}
