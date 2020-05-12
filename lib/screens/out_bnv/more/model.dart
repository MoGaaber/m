import 'package:flutter/cupertino.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/models/my_model.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';

class GridViewModel extends MyModelWithData<CompleteElementModel> {
  GridViewModel(BuildContext context, Map<String, dynamic> response)
      : super(context, response);

  @override
  List<CompleteElementModel> get getCastedResponse {
    List<CompleteElementModel> castedList = [];
    CompleteElementModel.context = context;
    data.forEach((element) {
      var horizontalListElement = CompleteElementModel.fromJson(element);
      if (!horizontalListElement.isEmptyTitle) {
        castedList.add(horizontalListElement);
      }
    });
    return castedList;
  }
}
