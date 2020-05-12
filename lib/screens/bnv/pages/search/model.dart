import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/models/my_model.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';

class SearchModel extends MyModelWithData<CompleteElementModel> {
  SearchModel(BuildContext context, Map<String, dynamic> response)
      : super(context, response);

  @override
  List<CompleteElementModel> get getCastedResponse {
    var horizontalListElements = List<CompleteElementModel>();
    data.forEach((element) {
      horizontalListElements.add(CompleteElementModel.fromJson(element));
    });
    return horizontalListElements;
  }
}
