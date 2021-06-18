import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';

class FilterModel {
  List<Response<Map<String, dynamic>>> response;
  List<City> cities;
  List<Feature> features;
  RangeValues priceRange;
  bool get pricRangeeNotChanged => priceRange == RangeValues(0, maxPrice);
  double get selectedMinPrice => priceRange.start;
  double get selectedMaxPrice => priceRange.end;

  FilterModel(BuildContext context, this.response) {
    this.cities = _cities(context);
    this.features = _features(context);
    this.priceRange = RangeValues(0, maxPrice);
  }

  double get maxPrice => successResponse<int>(0).toDouble();

  List _cities(BuildContext context) {
    var cities = successResponse<List>(1);
    List<City> castedCities = [];
    cities.forEach((city) {
      castedCities.add(City.fromJson(context, city));
    });

    return castedCities;
  }

  E successResponse<E>(int i) => response[i].data['success'];

  get successFeatures =>
      successResponse<Map<String, dynamic>>(2);

  List<Feature> _features(BuildContext context) {
    List<Feature> castedFeatures = [];

    successFeatures.forEach((k, v) {
      castedFeatures.add(Feature.fromJson(context, v));
    });
    return castedFeatures;
  }

  void clearCityList() {
    cities.forEach((element) {
      if (element.selected) element.selected = false;
    });
  }

  void clearFeatureList() {
    features.forEach((element) {
      if (element.selected) element.selected = false;
    });
  }

  void clearPrice() {
    if (priceRange != RangeValues(0, maxPrice))
      priceRange = RangeValues(0, maxPrice);
  }

  void clearAll() {
    clearCityList();
    clearFeatureList();
    clearPrice();
  }
}

class FilterElement {
  String name;
  bool selected = false;

  FilterElement(
    this.name,
  );

  void toggleSelect() => this.selected = !this.selected;
}

class City extends FilterElement {
  String id;

  City(String name, this.id) : super(name);

  factory City.fromJson(BuildContext context, Map<String, dynamic> json) {
    var translations = json['translations'];
    int index = translations.indexWhere((element) {
      return element['locale'] == Localization.of(context).locale.languageCode;
    });

    return City(json['translations'][index]['name'], json['id'].toString());
  }
  static int languageIndex(BuildContext context, List translations) =>
      translations.indexWhere((element) {
        return element['locale'] ==
            Localization.of(context).locale.languageCode;
      });
}

class Feature extends FilterElement {
  String query;
  Feature(String name, this.query) : super(name);

  factory Feature.fromJson(BuildContext context, Map<String, dynamic> json) {
    return Feature(
        json['translations'][Localization.of(context).locale.languageCode],
        json['name']);
  }
}
