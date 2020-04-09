import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/bnv.dart';
import 'package:m/logic.dart';
import 'package:m/screen.dart';
import 'package:m/trips.dart';
import 'package:provider/provider.dart';
import 'package:m/trips.dart';

class More extends StatelessWidget {
  static const route = '/more';
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            MyAppBar(),
            Expanded(
              child: NestedScrollView(
                  physics: BouncingScrollPhysics(),
                  headerSliverBuilder: (BuildContext context,
                          bool innerBoxIsScrolled) =>
                      [
                        SliverAppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          floating: true,
                          snap: true,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: screen.widthConverter(25),
                                      right: screen.widthConverter(25),
                                      top: screen.heightConverter(10),
                                      bottom: screen.heightConverter(0)),
                                  child: SearchTextField(
                                    edgeInsetsGeometry: EdgeInsets.symmetric(
                                        vertical: screen.heightConverter(10)),
                                    readOnly: false,
                                  )),
                            ),
                          ),
                          expandedHeight: screen.heightConverter(120),
                          leading: SizedBox.shrink(),
                        )
                      ],
                  body: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: GridView.count(
                        children: <Widget>[
                          for (var i = 0; i < 7; i++) GridCard()
                        ],
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: screen.widthConverter(19),
                            vertical: screen.heightConverter(5)),
                        childAspectRatio: (screen.widthConverter(156) /
                            screen.heightConverter(194)),
                        crossAxisSpacing: screen.widthConverter(16),
                        mainAxisSpacing: screen.heightConverter(13),
                        crossAxisCount: 2,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  bool readOnly;
  VoidCallback onTap;
  EdgeInsetsGeometry edgeInsetsGeometry;
  SearchTextField({this.readOnly = true, this.onTap, this.edgeInsetsGeometry});

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return MyTextField(
      'Search',
      onTap: onTap,
      readOnly: readOnly,
      contentPadding: this.edgeInsetsGeometry,
      color: Colors.white,
      shadow: [
        BoxShadow(blurRadius: (8), spreadRadius: (0), color: Color(0xffC9D1DC)),
      ],
      prefixIcon: Icon(
        FontAwesomeIcons.search,
        size: screen.heightConverter(12),
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
