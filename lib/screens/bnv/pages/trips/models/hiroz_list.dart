import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/models/image_and_text._model.dart';
import 'package:m/commons/models/my_model.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/methods.dart';

class HorizontalListElements
    extends MyModelWithDatWithHeader<CompleteElementModel> {
  HorizontalListElements(BuildContext context, Map<String, dynamic> response)
      : super(context, response);

  @override
  List<CompleteElementModel> get getCastedResponse {
    var horizontalListElements = List<CompleteElementModel>();
    CompleteElementModel.context = context;
    data.forEach((element) {
      horizontalListElements.add(CompleteElementModel.fromJson(
        element['tour'],
      ));
    });
    return horizontalListElements;
  }
}
