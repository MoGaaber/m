import 'package:flutter/material.dart';
import 'package:m/commons/models/image_and_text._model.dart';
import 'package:m/commons/models/my_model.dart';
import 'package:m/commons/utils/localization/localization.dart';

class SliderModel extends MyModel<ImageAndTextModel> {
  SliderModel(BuildContext context, Map<String, dynamic> response)
      : super(context, response);

  @override
  List<ImageAndTextModel> get getCastedResponse {
    var modelDataResponse = List<ImageAndTextModel>();
    for (var element in success) {
      modelDataResponse.add(ImageAndTextModel.fromJson(context, element));
    }
    return modelDataResponse;
  }
}
