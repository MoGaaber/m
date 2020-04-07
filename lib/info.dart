import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m/bnv.dart';
import 'package:m/book_flight.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';
import 'more.dart';
import 'trips.dart';
import 'main.dart';

String imageUrl =
    'https://onewayfreedom.com/wp-content/uploads/2018/09/The-Best-5-Cheap-Places-To-Travel-Around-The-World.jpg';

String loremipsum =
    "dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem “Nor is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but occasionally circumstances occur in which toil and pain can procure him some great pleasure.";

String shortLoremIpsum =
    'dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius';

class Info extends StatelessWidget {
  GoogleMapController googleMapController;
  static const route = '/info';
  @override
  Widget build(BuildContext context) {
    final screen = (Provider.of<Screen>(context));
    final theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return SafeArea(
        child: Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: NestedScrollView(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: screen.heightConverter(20),
                    left: screen.widthConverter(18.5),
                    right: screen.widthConverter(18.5),
                    bottom: screen.widthConverter(20)),
                child: Text(
                  'This string will be automatically resized to fit in two lines.',
                  style: textTheme.body2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(18.5)),
                child: Text(
                  loremipsum,
                  style: textTheme.body1,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    child: Text(
                      'more',
                      style: textTheme.body1
                          .copyWith(color: Theme.of(context).accentColor),
                    ),
                    padding: EdgeInsets.only(
                        right: screen.widthConverter(18.5),
                        top: screen.heightConverter(15),
                        bottom: screen.heightConverter(30))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(18.5)),
                child: SizedBox.fromSize(
                  size: Size.fromHeight(screen.heightConverter(200)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {},
                        initialCameraPosition:
                            CameraPosition(target: LatLng(30, 30), zoom: 8)),
                  ),
                ),
              ),
              Testt('Top experiences'),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(18.5)),
                child: SizedBox.fromSize(
                  size: Size.fromHeight(screen.heightConverter(200)),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 14,
                        child: ImageWithItsText(
                          alignmentGeometry: Alignment(0, 0.9),
                          imageUrl: imageUrl,
                          text: Text(
                            'Hello world',
                            style: textTheme.caption,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: screen.widthConverter(10.6))),
                      Flexible(
                        flex: 22,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ImageWithItsText(
                                imageUrl: imageUrl,
                                alignmentGeometry: Alignment(0, 0.5),
                                text: Text(
                                  'Hello world',
                                  style: textTheme.caption,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: screen.heightConverter(15.25))),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ImageWithItsText(
                                      alignmentGeometry: Alignment(0, 0.7),
                                      imageUrl: imageUrl,
                                      text: Text(
                                        'Hello world',
                                        style: textTheme.caption,
                                      ),
                                    ),
                                    flex: 7,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: screen.widthConverter(10))),
                                  Expanded(
                                    child: ImageWithItsText(
                                      opacity: 0.6,
                                      imageUrl: imageUrl,
                                      text: Text(
                                        '13+',
                                        style: textTheme.caption.copyWith(
                                            fontSize: ScreenUtil().setSp(20)),
                                      ),
                                    ),
                                    flex: 5,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: screen.heightConverter(40))),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(18.5)),
                child: Text(
                  'Italian Food',
                  style: textTheme.body2,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: screen.heightConverter(10))),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(18.5)),
                child: Text(
                  "“Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem “Nor is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but occasionally circumstances occur in which toil and pain can procure him some great pleasure",
                  style: textTheme.body1,
                ),
              ),
              Testt('Restaurant'),
              SizedBox.fromSize(
                size: Size.fromHeight(screen.heightConverter(160)),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: screen.widthConverter(18.5)),
                  physics: BouncingScrollPhysics(),
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) => SizedBox.fromSize(
                    size: Size.fromWidth(screen.widthConverter(133.84)),
                    child: ImageWithItsText(
                      alignmentGeometry: Alignment(0, 0.8),
                      imageUrl: imageUrl,
                      text: Text(
                        'Hello world',
                        style: textTheme.caption,
                      ),
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screen.widthConverter(13.6))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screen.heightConverter(34.5),
                    horizontal: screen.widthConverter(18.5)),
                child: MyFlatButton(
                  onTap: () {
                    Navigator.pushNamed(context, BookFlight.route);
                  },
                  text: 'Booking',
                ),
              )
            ],
          ),
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.white,
              expandedHeight: screen.heightConverter(200),
              flexibleSpace: FlexibleSpaceBar(
                  background: ImageWithItsText(
                haveRadius: false,
                imageUrl: imageUrl,
                text: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Trip to Rome',
                      style: textTheme.display2.copyWith(color: Colors.white),
                    ),
                    Padding(padding: EdgeInsets.only(top: 2)),
                    Text('a journey int the past',
                        style: textTheme.body2.copyWith(color: Colors.white)),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    MyRatingBar(screen.heightConverter(20)),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    ));
  }
}

class BnvIcon extends StatelessWidget {
  IconData iconData;
  Color color;
  VoidCallback onPressed;
  int index;
  BnvIcon({this.iconData, this.color, this.onPressed, this.index});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          this.iconData,
          color: this.color,
        ),
        onPressed: () {});
  }
}

class Testt extends StatelessWidget {
  String text;
  Testt(this.text);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Padding(
      padding: EdgeInsets.only(
          top: screen.heightConverter(23.5),
          bottom: screen.heightConverter(13),
          right: screen.widthConverter(18.5),
          left: screen.widthConverter(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(this.text, style: textTheme.body2),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(More.route);
            },
            child: Text(
              'Show More',
              style: textTheme.body2.copyWith(
                  color: theme.primaryColorLight,
                  fontSize: ScreenUtil().setSp(14)),
            ),
          )
        ],
      ),
    );
  }
}

class MyFlatButton extends StatelessWidget {
  String text;
  Color color, textColor;
  bool isIdle;
  VoidCallback onTap;

  MyFlatButton(
      {@required this.text,
      @required this.onTap,
      this.color = const Color(0xff005C15),
      this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return FlatButton(
      color: color,
      onPressed: this.onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.button.copyWith(color: textColor),
      ),
    );
  }
}

class ImageWithItsText extends StatelessWidget {
  String imageUrl;
  Widget text;
  AlignmentGeometry alignmentGeometry;
  double opacity;
  bool haveRadius;
  ImageWithItsText(
      {this.text,
      this.opacity = 0.3,
      this.alignmentGeometry = Alignment.center,
      this.imageUrl,
      this.haveRadius = true});

  @override
  Widget build(BuildContext context) {
    // any image stack with text => caption !
    Screen screen = Provider.of(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/info');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(haveRadius ? 12 : 0)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(this.opacity),
              ),
              Align(alignment: alignmentGeometry, child: text),
            ],
          ),
        ),
      ),
    );
  }
}
/*
isLast
                    ? textTheme.caption
                        .copyWith(fontSize: ScreenUtil().setSp(20))
          twoLines
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello Castle',
                        style: textTheme.caption,
                      ),
                      Text('4 of your Friends',
                          style: textTheme.caption.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(12),
                              color: Colors.white.withOpacity(0.7)))
                    ],
                  ),
                )
              : Align(
                  alignment: isLast ? Alignment.center : Alignment(0, 0.8),
                  child: Text(
                    isLast ? '13+' : 'Riyadh',
                    style: isLast
                        ? textTheme.caption
                            .copyWith(fontSize: ScreenUtil().setSp(20))
                        : textTheme.caption,
                  ),
                )

*/
