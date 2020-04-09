import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/bnv.dart';
import 'package:m/forget.dart';
import 'package:m/info.dart';
import 'package:m/screen.dart';
import 'package:m/trips.dart';
import 'package:provider/provider.dart';

class Filters extends StatelessWidget {
  static const route = '/filters';
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    print(screen.width);

    return SafeArea(
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: screen.widthConverter(18)),
                child: Text(
                  'Filters',
                  style: textTheme.display2,
                ),
              ),
              B('City', HirozSelectList()),
              B('Features', HirozSelectList()),
              B(
                'Distance',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screen.widthConverter(27)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            r'0k$',
                            style: textTheme.subtitle,
                          ),
                          Text(
                            r'10000$',
                            style: textTheme.subtitle,
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(top: screen.heightConverter(0))),
                    SizedBox.fromSize(
                      child: RangeSlider(
                          activeColor: Theme.of(context).accentColor,
                          max: 999,
                          min: 0,
                          values: RangeValues(0, 200),
                          onChanged: (x) {}),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screen.widthConverter(27)),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Distance range: ',
                            style: textTheme.subtitle
                                .copyWith(color: theme.primaryColorDark),
                          ),
                          Text(r' 1,000 $ - 7,500$',
                              style: textTheme.subtitle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: theme.primaryColorDark))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(),
      ),
    );
  }
}

class B extends StatelessWidget {
  String text;
  Widget body;
  B(this.text, this.body);
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: screen.widthConverter(18),
              top: screen.heightConverter(21),
              bottom: screen.heightConverter(12)),
          child: Text(this.text, style: textTheme.body2),
        ),
        body,
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: screen.heightConverter(20)),
        //   child: Divider(
        //     height: 0,
        //   ),
        //  )
      ],
    );
  }
}

class HirozSelectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return SizedBox.fromSize(
      child: ListView.builder(
        padding: EdgeInsets.only(left: screen.widthConverter(18)),
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: EdgeInsets.only(
            right: screen.widthConverter(15),
          ),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                /*
                border: Border.all(
                    width: screen.widthConverter(2),
                    color: Theme.of(context).accentColor),
                    */
                color: Color(0xffF1F3F6),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screen.widthConverter(10),
                  vertical: screen.heightConverter(11)),
              child: Text(
                'helloooooooo',
                style: GoogleFonts.robotoSlab(
                    fontSize: screen.aspectRatioConverter(12)),
              ),
            ),
          ),
        ),
      ),
      size: Size.fromHeight(screen.heightConverter(40)),
    );
  }
}
