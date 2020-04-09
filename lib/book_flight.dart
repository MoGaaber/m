import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/check_out.dart';
import 'package:m/info.dart';
import 'package:m/logic.dart';
import 'package:m/main.dart';
import 'package:m/screen.dart';
import 'package:m/sign_up.dart';
import 'package:provider/provider.dart';

import 'bnv.dart';
import 'forget.dart';

class BookFlight extends StatelessWidget {
  static const route = '/book';
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var theme = Theme.of(context);
    final textTheme = theme.textTheme;
    var smallButtontextStyle = textTheme.button.copyWith(
      fontSize: ScreenUtil().setSp(15),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screen.heightConverter(20)),
              child: Text(
                'Book This Tour',
                style: textTheme.display2,
              ),
            ),
            ButtonTheme(
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
            MyField('tour', 'Old Jeddah City Tour', () {}),
            MyField('Date', 'Select Date', () {
              selectDate(context);
            }),
            MyField('Passengers', '2 Adults', () {
              selectPassengers(context);
            }),
            FlatButton(
              onPressed: () {},
              child: Text('Booking'),
              color: theme.accentColor,
            ),
            Padding(
                padding: EdgeInsets.only(bottom: screen.heightConverter(20)))
          ],
          padding:
              EdgeInsets.symmetric(horizontal: screen.widthConverter(20.5)),
        ),
      ),
    ));
  }
}

class MyField extends StatelessWidget {
  String title;
  String subTitle;
  int index;
  VoidCallback onTap;

  MyField(this.title, this.subTitle, this.onTap);

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: screen.heightConverter(20)),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
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

void selectDate(BuildContext context) {
  showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050));
}

void selectPassengers(BuildContext context) {
  Screen screen = Provider.of(context, listen: false);
  ThemeData theme = Theme.of(context);
  TextTheme textTheme = theme.textTheme;

  showModalBottomSheet(
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
          behavior: MyBehavior(),
          child: ListView(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                trailing: Text('Done',
                    style: textTheme.body1.copyWith(
                        fontSize: ScreenUtil().setSp(15),
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700)),
                title: Text(
                  'Cancel',
                  style: textTheme.body1
                      .copyWith(fontSize: ScreenUtil().setSp(15)),
                ),
              ),
              Divider(
                height: 0,
              ),
              for (var i = 0; i < tiles.length; i++)
                PassengerTile(tiles[i].title, tiles[i].subTitle, i, setState),
              Padding(padding: EdgeInsets.only(top: screen.heightConverter(10)))
            ],
          ),
        ),
      ),
    ),
  );
}

List<PassengetTileModel> tiles = [
  PassengetTileModel('Adults', '16+ years'),
  PassengetTileModel(
    'Teens',
    '12-15 years',
  ),
  PassengetTileModel('Children', '2-11 years'),
  PassengetTileModel('Infant', 'under 2 years')
];

class PassengetTileModel {
  String title;
  String subTitle;
  int count;
  PassengetTileModel(this.title, this.subTitle, {this.count = 0});
}

class PassengerTile extends StatelessWidget {
  String title;
  String subTitle;
  int index;
  StateSetter setState;
  PassengerTile(this.title, this.subTitle, this.index, this.setState);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context, listen: false);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: screen.heightConverter(10)),

          // contentPadding:
          //     EdgeInsets.symmetric(vertical: screen.heightConverter(0)),
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
                    if (tiles[this.index].count != 0) {
                      tiles[this.index].count--;

                      this.setState(() {});
                    }
                  },
                ),
                Text(tiles[index].count.toString(), style: textTheme.display2),
                MyButton(
                  color: Theme.of(context).accentColor,
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    tiles[this.index].count++;
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
  Color color;
  VoidCallback onPressed;
  IconData icon;
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
