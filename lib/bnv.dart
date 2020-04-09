import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/book_flight.dart';
import 'package:m/check_out.dart';
import 'package:m/profile.dart';
import 'package:m/screen.dart';
import 'package:m/search.dart';
import 'package:m/trips.dart';
import 'package:provider/provider.dart';

import 'info.dart';

class BnvModel {
  IconData iconData;
  bool selected;
  Widget body;
  Widget appBar;

  BnvModel(this.iconData, this.body, this.appBar, {this.selected = false});
}

class Bnv extends StatefulWidget {
  static const route = '/bnv';
  @override
  _BnvState createState() => _BnvState();
}

class SearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Flights',
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _BnvState extends State<Bnv> {
  int oldIndex = 0;
  int currentIndex = 0;
  var myIcons = [
    BnvModel(FontAwesomeIcons.suitcaseRolling, Trips(), MyAppBar(),
        selected: true),
    BnvModel(FontAwesomeIcons.search, Search(), SearchAppBar()),
    BnvModel(FontAwesomeIcons.calendarAlt, BookFlight(), AppBar()),
    BnvModel(FontAwesomeIcons.user, Profile(), AppBar())
  ];

  @override
  Widget build(BuildContext context) {
    final screen = (Provider.of<Screen>(context));

    return SafeArea(
        child: Scaffold(
      body: ScrollConfiguration(
        child: myIcons[currentIndex].body,
        behavior: MyBehavior(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: screen.aspectRatioConverter(10),
              spreadRadius: screen.aspectRatioConverter(5),
              color: Colors.black.withOpacity(0.1))
        ], color: Colors.white),
        height: screen.heightConverter(50),
        // color: Color(0xffF4F4F4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (int i = 0; i < 4; i++)
              GestureDetector(
                  child: AnimatedPadding(
                    padding:
                        EdgeInsets.only(bottom: myIcons[i].selected ? 10 : 0),
                    child: LayoutBuilder(
                        builder: (_, BoxConstraints boxConstraints) {
                      return Icon(
                        myIcons[i].iconData,
                        size: screen.heightConverter(50 / 2.2),
                        color: myIcons[i].selected
                            ? Theme.of(context).accentColor
                            : Color(0xff577584),
                      );
                    }),
                    duration: Duration(milliseconds: 100),
                  ),
                  onTap: () {
                    myIcons[currentIndex].selected = false;
                    this.currentIndex = i;
                    myIcons[currentIndex].selected = true;
                    setState(() {});
                  }),
          ],
        ),
      ),
    ));
  }
}
