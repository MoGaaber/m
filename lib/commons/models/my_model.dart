import 'package:flutter/cupertino.dart';
import 'package:m/commons/utils/methods.dart';

abstract class MyModel<CR> {
  var castedResponse = List<CR>();
  Map<String, dynamic> response;
  BuildContext context;

  MyModel(this.context, this.response) {
    this.castedResponse = getCastedResponse;
  }
  dynamic get success => response['success'];

  List<CR> get getCastedResponse;
}

abstract class MyModelWithData<CR> extends MyModel<CR> {
  MyModelWithData(BuildContext context, Map<String, dynamic> response)
      : super(context, response);
  List get data => success['data'];
}

abstract class MyModelWithDatWithHeader<CR> extends MyModelWithData<CR> {
  MyModelWithDatWithHeader(BuildContext context, Map<String, dynamic> response)
      : super(context, response);
  String get header =>
      headerTranslations[Methods.languageIndex(context, headerTranslations)]
          ['title'];

  Map<String, dynamic> get headerRoot => success['header'];

  List get headerTranslations => headerRoot['translations'];
}
