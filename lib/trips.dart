import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/bnv.dart';
import 'package:m/filter.dart';
import 'package:m/info.dart';
import 'package:m/more.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'info.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screen.widthConverter(10)),
          child: IconButton(
              icon: Icon(
                FontAwesomeIcons.slidersH,
                color: Color(0xff323B45),
                size: screen.heightConverter(20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, Filters.route);
              }),
        )
      ],
      centerTitle: true,
      title: Image.asset(
        'assets/logo.png',
        fit: BoxFit.fitHeight,
//            width: 40,
        height: screen.heightConverter(21),
      ),
      // title: Text('Touri'),
    );
  }
}

class Trips extends StatelessWidget {
  static const route = '/trips';
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: screen.widthConverter(10)),
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.slidersH,
                      color: Color(0xff323B45),
                      size: screen.heightConverter(20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Filters.route);
                    }),
              )
            ],
            centerTitle: true,
            title: Image.asset(
              'assets/logo.png',
              fit: BoxFit.fitHeight,
//            width: 40,
              height: screen.heightConverter(21),
            ),
            // title: Text('Touri'),
          ),
          SliverPadding(
              padding: EdgeInsets.only(top: screen.heightConverter(10))),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screen.widthConverter(7.5)),
              child: SizedBox.fromSize(
                size: Size.fromHeight(screen.heightConverter(200)),
                child: Stack(
                  overflow: Overflow.visible,
                  fit: StackFit.loose,
                  children: <Widget>[
                    ImageWithItsText(
                      imageUrl: imageUrl,
                      text: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Trip to Italy',
                              style: textTheme.display2
                                  .copyWith(color: Colors.white)),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: screen.widthConverter(10))),
                          Text('a journey into the past',
                              style: textTheme.body2.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: screen.heightConverter(-45),
                      height: screen.heightConverter(70),
                      left: screen.widthConverter(30),
                      child: SizedBox.fromSize(
                        size: Size.fromWidth(screen.widthConverter(300)),
                        child: SearchTextField(
                          readOnly: true,
                          onTap: () {
                            Navigator.pushNamed(context, '/search',
                                arguments: true);

                            print('hello');
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
              padding: EdgeInsets.only(top: screen.heightConverter(50))),
          SliverToBoxAdapter(
            child: Testt('Top Destionnt'),
          ),
          SliverPadding(
            padding:
                EdgeInsets.symmetric(horizontal: screen.widthConverter(16.66)),
            sliver: SliverGrid.count(
              crossAxisSpacing: screen.widthConverter(7.16),
              mainAxisSpacing: screen.widthConverter(7.16),
              crossAxisCount: 2,
              childAspectRatio:
                  screen.widthConverter(166.84) / screen.heightConverter(161),
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  ImageWithItsText(
                    onTap: () {
                      Navigator.pushNamed(context, '/info');
                    },
                    imageUrl: imageUrl,
                    alignmentGeometry: Alignment(0, 0.90),
                    text: Text(
                      'Hello world',
                      style: textTheme.caption,
                    ),
                  )
              ],
            ),
          ),
          SliverToBoxAdapter(child: Testt('Top Destination')),
          SliverToBoxAdapter(
            child: SizedBox.fromSize(
              size: Size.fromHeight(screen.heightConverter(161)),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: screen.widthConverter(16)),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                  child: ImageWithItsText(
                    onTap: () {
                      Navigator.pushNamed(context, '/info');
                    },
                    imageUrl: imageUrl,
                    alignmentGeometry: Alignment(0, 0.90),
                    text: Column(
                      mainAxisSize: MainAxisSize.min,
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
                  ),
                  width: screen.widthConverter(133),
                ),
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screen.widthConverter(4))),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Testt('Top Destinationn')),
          SliverPadding(
            padding: EdgeInsets.only(
              left: screen.widthConverter(19),
              right: screen.widthConverter(19),
              bottom: screen.heightConverter(120),
            ),
            sliver: SliverGrid.count(
              mainAxisSpacing: screen.heightConverter(20),
              childAspectRatio:
                  screen.widthConverter(158) / screen.heightConverter(200),
              children: <Widget>[for (var i = 0; i < 6; i++) GridCard()],
              crossAxisCount: 2,
              crossAxisSpacing: screen.widthConverter(16),
            ),
          ),
        ],
      ),
    );
  }
}

class GridCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    final theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/info');
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(screen.widthConverter(10))),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  // width: screen.widthConverter(158),
                  // height: screen.heightConverter(100),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Edinburgh Zoo',
                  style: textTheme.body1,
                ),
                Text(
                  r"26$",
                  style: textTheme.body2,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Text('4 of your friends like this spot friends like this spot',
                style: textTheme.body1.copyWith(
                    fontFamily: 'RobotoSlab',
                    color: Color(0xff5C6979),
                    fontSize: ScreenUtil().setSp(10))),
            Padding(padding: EdgeInsets.only(top: 4)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyRatingBar(screen.heightConverter(14)),
                Text('6 deals left', style: textTheme.overline)
              ],
            ),
          ]),
    );
  }
}

class MyRatingBar extends StatelessWidget {
  double itemSize;
  MyRatingBar(this.itemSize);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemSize: this.itemSize,
      itemCount: 5,
      rating: 4,
      unratedColor: Colors.grey,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Color(0xffFDC60A),
      ),
    );
  }
}
