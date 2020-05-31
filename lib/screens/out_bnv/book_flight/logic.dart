import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/constants/constants.dart';
import 'package:m/screens/out_bnv/book_flight/ui.dart';

class BookFlightLogic extends ChangeNotifier {
  DateTime selectedDate;
  // DateTime selectedDateInDateTimeForm ;
  int tourId;
  void bookTour() {
    Dio().post(ApisUrls.book, options: Options(), data: {
      'tour': tourId,
      'starts_at': selectedDate,
      'adult_quantity': tiles[0].count,
      'child_quantity': tiles[1].count,
      'infant_quantity': tiles[2].count,
    });
  }

  Future<void> selectDate(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (date != null) {
      this.selectedDate = date;

      notifyListeners();
    }
  }

  String get formattedDate {
    var formatter = new DateFormat('dd/MM/yyyy');
    if (selectedDate == null) {
      return null;
    }
    String formattedDate = formatter.format(this.selectedDate);
    return formattedDate;
  }

  bool get isValidInfo {}
}
