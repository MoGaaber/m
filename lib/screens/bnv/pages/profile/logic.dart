import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/main.dart';

import 'model.dart';
import 'widgets/info.dart';

enum GeoCodingState { wait, success, error }

class ProfileLogic with ChangeNotifier {
  Position currentPosition;
  GeoCodingState geoCodingState;
  Future<Response<Map<String, dynamic>>> getProfileInfo;
  var user;

  Future<void> signOut() async {
    await sharedPreferences.setBool('isLoggedIn', false);
    notifyListeners();
  }

  ProfileLogic() {
    getProfileInfo = fetchProfileInfo();
  }

  Future<Response<Map<String, dynamic>>> fetchProfileInfo() async {
    var token = sharedPreferences.getString("token");
    return await Dio().get<Map<String, dynamic>>(ApisUrls.profile,
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }));
  }

  void unFetchProfileInfo() {
    this.getProfileInfo = null;
  }

  Future<void> refresh() {
    unFetchProfileInfo();
    notifyListeners();
    return getProfileInfo = fetchProfileInfo();
  }
}
