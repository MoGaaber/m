import 'package:flutter/material.dart';
import 'package:m/commons/models/image_and_text._model.dart';
import 'package:m/commons/models/my_model.dart';

class GridListModel extends MyModelWithDatWithHeader<ImageAndTextModelWithId> {
  GridListModel(BuildContext context, Map<String, dynamic> response)
      : super(context, response);

  @override
  List<ImageAndTextModelWithId> get getCastedResponse {
    var gridList = List<ImageAndTextModelWithId>();
    for (var item in data) {
      gridList.add(ImageAndTextModelWithId.fromJson(context, item));
    }
    return gridList;
  }
}
