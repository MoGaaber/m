import 'package:carousel_slider/carousel_options.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:m/screens/out_bnv/more/ui.dart';

typedef void Tap(BuildContext context, CompleteElementModel elementModel);

class TripsLogic with ChangeNotifier {
  Future<Response<Map<String, dynamic>>> getSlider;
  Future<Response<Map<String, dynamic>>> getTopDestinations;
  Future<Response<Map<String, dynamic>>> getPopular;
  Future<Response<Map<String, dynamic>>> getWonderful;
  Future<Response<Map<String, dynamic>>> getRecommended;
  bool haveNetWorkError = false;
  int currentSliderIndex = 0;

  void onSliderPageChanged(int index, CarouselPageChangedReason reason) {
    this.currentSliderIndex = index;
    notifyListeners();
  }

  void onTap(BuildContext context, CompleteElementModel elementModel) =>
      Navigator.pushNamed(context, InfoRoot.route, arguments: elementModel);

  void onTapHirozList(BuildContext context, elementModel) =>
      Navigator.pushNamed(context, InfoRoot.route, arguments: elementModel);
  void onTapGridList(BuildContext context, id) =>
      Navigator.pushNamed(context, MoreRoot.route,
          arguments: {'id': id, 'widget': MoreOnline()});

  TripsLogic() {
    getSlider = Dio().get(ApisUrls.slider);
    getTopDestinations = Dio().get(ApisUrls.topDestinations);
    getPopular = Dio().get(ApisUrls.popular);
    getWonderful = Dio().get(ApisUrls.topDeals);
    getRecommended = Dio().get(ApisUrls.recommended);
  }

  Future<void> fetchApi() async {
    unfetchApi();
    if (await DataConnectionChecker().hasConnection &&
        await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      haveNetWorkError = false;
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
    } else {
      haveNetWorkError = true;
      notifyListeners();
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
