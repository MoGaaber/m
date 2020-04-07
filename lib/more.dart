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
        body: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
                      SliverAppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        floating: true,
                        snap: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Center(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: screen.widthConverter(40),
                                    right: screen.widthConverter(40),
                                    top: screen.heightConverter(0),
                                    bottom: screen.heightConverter(0)),
                                child: SearchTextField(
                                  readOnly: false,
                                )),
                          ),
                        ),
                        expandedHeight: screen.heightConverter(120),
                      )
                    ],
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(19),
                    vertical: screen.heightConverter(5)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: screen.widthConverter(16),
                    mainAxisSpacing: screen.heightConverter(13),
                    childAspectRatio: (screen.widthConverter(156) /
                        screen.heightConverter(194)),
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) => GridCard(),
              ),
            )),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  bool readOnly;
  VoidCallback onTap;

  SearchTextField({this.readOnly = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return MyTextField(
      'Search',
      onTap: onTap,
      readOnly: readOnly,
      // contentPadding:
      //     EdgeInsets.symmetric(vertical: screen.heightConverter(10)),
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
