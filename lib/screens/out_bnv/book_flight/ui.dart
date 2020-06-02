import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/main.dart';
import 'package:m/screens/out_bnv/auth/ui/login.dart';
import 'package:m/screens/out_bnv/auth/ui/register.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class BookFlight extends StatelessWidget {
  static const route = '/book';

  @override
  Widget build(BuildContext context) {
    BookFlightLogic logic =
        Provider.of<BookFlightLogic>(context, listen: false);

    logic.init(context);
    Screen screen = Provider.of(context);
    var theme = Theme.of(context);
    final textTheme = theme.textTheme;
    var smallButtontextStyle = textTheme.button.copyWith(
      fontSize: ScreenUtil().setSp(15),
    );
    Map<String, dynamic> data = ModalRoute.of(context).settings.arguments;
    logic.tourId = data['tourId'];
    logic.selectedDate = null;

    return Scaffold(
      key: logic.scaffoldKey,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: screen.heightConverter(40),
                bottom: screen.heightConverter(20)),
            child: Text(
              logic.localization[0],
              style: textTheme.display2,
            ),
          ),
          sharedPreferences.getBool('isLoggedIn')
              ? SizedBox.shrink()
              : ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screen.aspectRatioConverter(10)))),
                  height: screen.heightConverter(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          color: theme.canvasColor,
                          onPressed: () {
                            Navigator.pushNamed(context, Login.route);
                          },
                          child: Text('Sign in',
                              style: smallButtontextStyle.copyWith(
                                  color: theme.primaryColorDark)),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: screen.widthConverter(21))),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignUp.route);
                          },
                          child: Text('Sign up', style: smallButtontextStyle),
                          color: theme.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(bottom: screen.heightConverter(20)),
          ),
          MyField('tour', data['name'], null),
          Selector<BookFlightLogic, String>(
            builder: (BuildContext context, String value, Widget child) =>
                MyField(
              'Date',
              value ?? 'Select Date',
              () {
                logic.selectDate(context);
              },
              isValid: logic.isFormattedDateValid,
            ),
            selector: (BuildContext, BookFlightLogic logic) =>
                logic.formattedDate,
          ),
          Selector<BookFlightLogic, String>(
              selector: (BuildContext, BookFlightLogic logic) =>
                  logic.passengers,
              builder: (BuildContext context, String value, Widget child) =>
                  MyField(
                    'Passengers',
                    value,
                    logic.selectPassengers,
                    isValid: logic.isPassengersValid,
                  )),
          Padding(
            padding: EdgeInsets.only(
                bottom: screen.heightConverter(20),
                top: screen.heightConverter(40)),
            child: FlatButton(
              onPressed: logic.bookTour,
              child: Text('Booking'),
              color: theme.accentColor,
            ),
          ),
        ],
        padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(20.5)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MyField extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  bool isValid;

  MyField(this.title, this.subTitle, this.onTap, {this.isValid = true});

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    BookFlightLogic logic =
        Provider.of<BookFlightLogic>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(bottom: screen.heightConverter(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF5F5F5),
          border:
              this.isValid ? null : Border.all(color: Colors.red, width: 1.5.w),
          borderRadius: BorderRadius.all(
              Radius.circular(screen.aspectRatioConverter(10))),
        ),
        child: ListTile(
          onTap: this.onTap,
          // contentPadding: EdgeInsets.symmetric(
          //     vertical: screen.heightConverter(10),
          //     horizontal: screen.widthConverter(10)),
          subtitle: Text(
            subTitle,
            style: textTheme.body2,
          ),
          title: Text(title, style: textTheme.subtitle.copyWith()),
        ),
      ),
    );
  }
}

class PassengetTileModel {
  String title;
  String subTitle;
  int count;
  PassengetTileModel(this.title, this.subTitle, {this.count = 0});
  void setCountZero() => count = 0;
}

class PassengerTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final int index;
  final StateSetter setState;
  PassengerTile(this.title, this.subTitle, this.index, this.setState);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context, listen: false);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    BookFlightLogic logic =
        Provider.of<BookFlightLogic>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: screen.heightConverter(10)),
          trailing: SizedBox.fromSize(
            size: Size.fromWidth(screen.widthConverter(112)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                MyButton(
                  color: Colors.grey,
                  icon: FontAwesomeIcons.minus,
                  onPressed: () {
                    if (logic.tiles[this.index].count != 0) {
                      logic.tiles[this.index].count--;

                      this.setState(() {});
                    }
                  },
                ),
                Text(logic.tiles[index].count.toString(),
                    style: textTheme.display2),
                MyButton(
                  color: Theme.of(context).accentColor,
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    logic.tiles[this.index].count++;
                    this.setState(() {});
                  },
                )
              ],
            ),
          ),
          leading: Icon(
            FontAwesomeIcons.male,
            color: Theme.of(context).accentColor,
            size: screen.heightConverter(30),
          ),
          title: Text(
            title,
            style: textTheme.subhead.copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(subTitle, style: textTheme.subtitle),
        ),
        index == 3
            ? SizedBox.shrink()
            : Divider(
                height: 0,
              )
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final IconData icon;
  MyButton({this.color, this.onPressed, this.icon});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context, listen: false);
    return SizedBox(
      height: screen.heightConverter(25),
      width: screen.widthConverter(25),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: color,
        onPressed: onPressed,
        child: Icon(
          this.icon,
          color: Colors.white,
          size: screen.aspectRatioConverter(14),
        ),
      ),
    );
  }
}
