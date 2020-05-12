import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';

class TripsLogic with ChangeNotifier {
  Future<Response<Map<String, dynamic>>> getSlider;
  Future<Response<Map<String, dynamic>>> getTopDestinations;
  Future<Response<Map<String, dynamic>>> getPopular;
  Future<Response<Map<String, dynamic>>> getWonderful;
  Future<Response<Map<String, dynamic>>> getRecommended;

  TripsLogic() {
    fetchApi();
  }

  Future<void> fetchApi() async {
    unfetchApi();
    try {
      return await Future.wait([
        getSlider = fetchSlider(),
        getTopDestinations = fetchTopDestination(),
        getPopular = fetchPopular(),
        getWonderful = fetchTopDeals(),
        getRecommended = fetchRecommended()
      ]);
    } catch (e) {
      print(e);
    }
  }

  Future<Response<Map<String, dynamic>>> fetchSlider() async =>
      await Dio().get(ApisUrls.slider);
  Future<Response<Map<String, dynamic>>> fetchTopDestination() async =>
      await Dio().get(ApisUrls.topDestinations);
  Future<Response<Map<String, dynamic>>> fetchPopular() async =>
      await Dio().get(ApisUrls.popular);
  Future<Response<Map<String, dynamic>>> fetchTopDeals() async =>
      await Dio().get(ApisUrls.topDeals);
  Future<Response<Map<String, dynamic>>> fetchRecommended() async =>
      await Dio().get(ApisUrls.recommended);

  void unfetchApi() {
    getSlider = null;
    getTopDestinations = null;
    getPopular = null;
    getWonderful = null;
    getRecommended = null;
    notifyListeners();
  }
}
