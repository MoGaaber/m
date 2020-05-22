import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:m/commons/utils/methods.dart';

class ImageAndTextModelWithId extends ImageAndTextModel {
  int id;

  ImageAndTextModelWithId(String mainImage, String title, this.id)
      : super(mainImage, title);

  factory ImageAndTextModelWithId.fromJson(
      BuildContext context, Map<String, dynamic> json) {
    var country = json['country'];
    var translations = country['translations'];
    var languageIndex = Methods(context).languageIndex(translations);
    var translation = translations[languageIndex];
    var mainImage = json['mainImagePath'];
    var title = translation['name'];
    var countryId = country['id'];

    return ImageAndTextModelWithId(mainImage, title, countryId);
  }
}

class ImageAndTextModel {
  String mainImage, title;
  bool errorInLoadImage = false;
  ImageAndTextModel(
    this.mainImage,
    this.title,
  );
  // String message(Object error) {
  //   if (error is HttpException) {
  //     return 'server';
  //   } else if (error is SocketException) {
  //     return 'network ';
  //   } else {
  //     return 'unknown';
  //   }
  // }

  factory ImageAndTextModel.fromJson(
      BuildContext context, Map<String, dynamic> json) {
    var translations = json['translations'];
    var languageIndex = Methods(context).languageIndex(translations);
    var data = translations[languageIndex];
    var mainImage = json['mainImagePath'];
    var title = data['descriptionData'];

    return ImageAndTextModel(mainImage, title);
  }
}
