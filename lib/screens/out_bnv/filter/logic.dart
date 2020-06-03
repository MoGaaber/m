import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/out_bnv/more/model.dart';
import 'package:m/screens/out_bnv/more/ui.dart';
import 'package:m/screens/out_bnv/more/widgets/gridview.dart';

import 'model.dart';

class FilterLogic extends ChangeNotifier {
  Future<List<Response<Map<String, dynamic>>>> apiRequest;
  FilterModel filterModel;
  var selectedCities = List<City>();
  String selectedFeature;
  String selectedFeatureTemp;
  RangeValues selectedPriceRange;
  bool clearFilterState = false;
  int oldFeatureIndex;
  int oldCityIndex;

  void onChangeRange(RangeValues priceRange) {
    filterModel.priceRange = priceRange;
    notifyListeners();
  }

  FilterLogic() {
    apiRequest = Future.wait([
      Dio().get(ApisUrls.maxPrice),
      Dio().get(ApisUrls.cities),
      Dio().get(ApisUrls.features)
    ]);
  }

  void selectCities(int index) {
    filterModel.cities[index].toggleSelect();
    notifyListeners();
  }

  void selectFeatures(int index) {
    print(index);
    if (oldFeatureIndex == null) {
      oldFeatureIndex = index;
    }
    if (index == oldFeatureIndex) {
      filterModel.features[index].toggleSelect();
      if (filterModel.features[index].selected) {
        selectedFeatureTemp = filterModel.features[index].query;
      } else {
        selectedFeatureTemp = null;
      }
    } else {
      filterModel.features[index].selected = true;
      selectedFeatureTemp = filterModel.features[index].query;
      filterModel.features[oldFeatureIndex].selected = false;
    }
    print(selectedFeatureTemp);
    oldFeatureIndex = index;
    notifyListeners();
  }

  Map<String, dynamic> get getFilterForm {
    Map<String, dynamic> filterForm = {};

    if (selectedFeatureTemp != null) {
      selectedFeature = selectedFeatureTemp;
      filterForm['feature[]'] = selectedFeatureTemp;
    }
    if (!filterModel.pricRangeeNotChanged) {
      selectedPriceRange = filterModel.priceRange;
      filterForm['price'] = filterModel.selectedMinPrice.toString() +
          ';' +
          filterModel.selectedMaxPrice.toString();
    }
    selectedCities =
        filterModel.cities.where((x) => x.selected == true).toList();

    if (!isSelectedCitiesEmpty) {
      var citiesQuery = selectedCities.reduce((x, y) {
        return City(null, x.id + ',' + y.id);
      });
      filterForm['city[]'] = citiesQuery.id;
    }

    return filterForm;
  }

  Future<void> refresh() {
    apiRequest = null;
    print('!!');
    notifyListeners();

    return apiRequest = fetchApiRequest();
  }

  Future<List<Response<Map<String, dynamic>>>> fetchApiRequest() async {
    return await Future.wait([
      Dio().get(ApisUrls.maxPrice),
      Dio().get(ApisUrls.cities),
      Dio().get(ApisUrls.features)
    ]);
  }

  Future<void> filter(BuildContext context) async {
    Response<Map<String, dynamic>> response = await Dio().post(
        ApisUrls.searchAndFilter,
        options: Options(),
        data: FormData.fromMap(getFilterForm));

    Navigator.pushNamed(context, MoreRoot.route,
        arguments: NormalGridView(GridViewModel(context, response.data)));
  }

  void attachData(BuildContext context, snapshot) {
    filterModel = FilterModel(context, snapshot);

    var selectedFeatureIndex = filterModel.features.indexWhere((element) {
      return element.query == selectedFeature;
    });

    if (selectedFeatureIndex != -1)
      filterModel.features[selectedFeatureIndex].selected = true;

    for (var i = 0; i < filterModel.cities.length; i++) {
      for (var j = 0; j < selectedCities.length; j++) {
        if (filterModel.cities[i].id == selectedCities[j].id) {
          filterModel.cities[i].selected = true;
        }
      }
    }

    if (selectedPriceRange != null) filterModel.priceRange = selectedPriceRange;
  }

  bool get isSelectedCitiesEmpty => selectedCities.isEmpty;

  void clearFilter() {
    if (!isSelectedCitiesEmpty) selectedCities.clear();
    if (selectedFeature != null) selectedFeature = null;
    if (selectedPriceRange != null) selectedPriceRange = null;
    filterModel.clearAll();
    clearFilterState = !clearFilterState;
    notifyListeners();
  }
}
