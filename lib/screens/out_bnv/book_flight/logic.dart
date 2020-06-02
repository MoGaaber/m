import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/methods.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/scroll_behavior.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/out_bnv/book_flight/ui.dart';
import 'package:provider/provider.dart';

class BookFlightLogic extends ChangeNotifier {
  DateTime selectedDate;
  String passengers;
  int tourId;
  List<PassengetTileModel> tiles;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> localization;
  BuildContext context;
  BookFlightLogic();
  void setPassengersDefault() => passengers = '0 ${localization[5]}';

  void init(BuildContext context) {
    this.context = context;
    localization = Localization.of(context).book;
    setPassengersDefault();
    var year = localization[13];
    tiles = [
      PassengetTileModel(localization[9], '16+ $year'),
      PassengetTileModel(localization[10], '2-16 $year'),
      PassengetTileModel(localization[11], '${localization[12]} 2 $year')
    ];
  }

  Future<void> bookTour() async {
    var methods = Methods(context);

    if (isValid) {
      try {
        await methods.showProgressDialog();
        var apiRequest =
            await Dio().post(ApisUrls.book, options: Options(), data: {
          'tour': tourId,
          'starts_at': formattedDate,
          'adult_quantity': tiles[0].count,
          'child_quantity': tiles[1].count,
          'infant_quantity': tiles[2].count,
        });
        await methods.hideProgressDialog();

        Methods.showSnackBar(scaffoldKey, localization[16]);
      } catch (e) {
        Methods.showSnackBar(scaffoldKey, localization[15]);
      }
    } else {
      Methods.showSnackBar(scaffoldKey, localization[14]);
    }
//    await methods.showProgressDialog();
  }

  Future<void> selectDate(BuildContext context) async {
    var date = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          var theme = Theme.of(context);
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: theme.accentColor,
              accentColor: theme.accentColor,
              colorScheme: ColorScheme.light(primary: theme.accentColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
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

  bool get isFormattedDateValid {
    if (formattedDate == null) {
      return false;
    } else {
      return true;
    }
  }

  bool get isPassengersValid {
    if (passengers == '0 ${localization[5]}') {
      return false;
    } else {
      return true;
    }
  }

  bool get isValid {
    if (isFormattedDateValid && isPassengersValid) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidInfo {}
  Future<void> selectPassengers() async {
    Screen screen = Provider.of(context, listen: false);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    bool isX = false;
    var counts = tiles.map((e) => e.count).toList();
    await showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screen.widthConverter(20),
          ),
          child: ScrollConfiguration(
            behavior: MyScrollBehavior(),
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  trailing: GestureDetector(
                    onTap: () {
                      this.passengers = '';
                      isX = true;
                      for (int i = 0; i < tiles.length; i++) {
                        var element = tiles[i];
                        if (element.count != 0) {
                          this.passengers +=
                              '${element.count} ${element.title} , ';
                        }
                      }
                      if (this.passengers.isEmpty) {
                        setPassengersDefault();
                      }

                      Navigator.pop(context);
                      notifyListeners();
                    },
                    child: Text(localization[6],
                        style: textTheme.body1.copyWith(
                            fontSize: ScreenUtil().setSp(15),
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700)),
                  ),
                  title: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          localization[7],
                          style: textTheme.body1
                              .copyWith(fontSize: ScreenUtil().setSp(15)),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10.h)),
                      GestureDetector(
                        onTap: () {
                          clearAllCount();
                          setState(() {});
                        },
                        child: Text(
                          localization[8],
                          style: textTheme.body1
                              .copyWith(fontSize: ScreenUtil().setSp(15)),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: tiles.length,
                    itemBuilder: (BuildContext context, int i) => PassengerTile(
                        tiles[i].title, tiles[i].subTitle, i, setState),
                    separatorBuilder: (BuildContext context, int index) =>
                        Padding(
                            padding: EdgeInsets.only(
                                top: screen.heightConverter(10))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    if (!isX) {
      for (int i = 0; i < tiles.length; i++) {
        tiles[i].count = counts[i];
      }
    }
  }

  void clearAllCount() => tiles.forEach((element) {
        element.setCountZero();
      });
}
