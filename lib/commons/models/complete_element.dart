import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/methods.dart';

class CompleteElementModel {
  dynamic lat, adultPrice;
  dynamic id;
  String lon;
  List otherImages;
  String mainImagePath;
  List translations;
  List related = [];
  bool toggleMoreLess = true;

  static BuildContext context;
  static String languageCode = deviceLanguageCode;

  CompleteElementModel({
    @required this.id,
    this.lat,
    this.lon,
    this.adultPrice,
    this.otherImages,
    this.mainImagePath,
    this.translations,
    this.related,
  });

  static String get deviceLanguageCode =>
      Localization.of(context).locale.languageCode;

  Map<String, dynamic> get _getTranslation {
    
    return translations[
        Methods.customlanguageIndex(translations, languageCode)];
  }

  String get overView => _getTranslation['overviewData'].trim();

  String get _title => _getTranslation['title']?.trim() ?? '';
  bool get isEmptyTitle => _title.isEmpty;
  int get titleLength => _title.length;
  bool get isLongTitle => titleLength >= 50 ? true : false;
  String get getTitle => isLongTitle ? _title.substring(0, 50) + '...' : _title;

  String get highLights => (_getTranslation['highlightsData'] as String).trim();

  bool get isOtherImagesEmpty => this.otherImages.isEmpty;

  bool get isNullLatlng => this.lat == null || this.lon == null;
  LatLng get latLng =>
      isNullLatlng ? null : LatLng(double.parse(lat), double.parse(lon));

  bool get isOverViewLong => this.overView.length > 200 ? true : false;

  String get getOverView => isOverViewLong && this.toggleMoreLess
      ? shortOverView + '  .......'
      : this.overView;
  void setToogleMoreLess() => this.toggleMoreLess = !toggleMoreLess;
  String get shortOverView => overView.substring(0, 200);

  List get getAllImages {
    var images = List();
    images.add(this.mainImagePath);
    images.addAll(this.otherImages);

    return images;
  }

  bool get isRelatedEmpty => related.isEmpty;
  factory CompleteElementModel.fromJson(Map<String, dynamic> json) =>
      CompleteElementModel(
        id: json['id'],
        lat: json["lat"],
        lon: json["lon"],
        adultPrice: json['adult_price'] ?? '',
        otherImages: json["otherImagesPath"] ?? [],
        mainImagePath: json["mainImagePath"],
        translations: json["translations"],
        related: json["related"],
      );
}
