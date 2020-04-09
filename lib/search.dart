import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/logic.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';

import 'info.dart';
import 'main.dart';

class Search extends StatelessWidget {
  static const route = '/search';
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    bool withScaffold = ModalRoute.of(context).settings.arguments ?? false;

    return withScaffold
        ? SafeArea(
            child: Scaffold(
            body: SearchBody(),
            appBar: AppBar(
              title: Text(
                'Flights',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    fontFamily: 'OpenSans',
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ))
        : SearchBody();
  }
}

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);

    return Padding(
      padding: EdgeInsets.only(
          top: screen.heightConverter(10),
          left: screen.widthConverter(20),
          right: screen.widthConverter(20)),
      child: Column(
        children: <Widget>[
          MyTextField('Search',
              contentPadding: EdgeInsets.symmetric(
                  vertical: screen.heightConverter(10),
                  horizontal: screen.widthConverter(10)),
              trailling: Material(
                shape: CircleBorder(),
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.close,
                    size: screen.aspectRatioConverter(25),
                  ),
                ),
              )),
          Padding(padding: EdgeInsets.only(top: screen.heightConverter(16))),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Info.route);
                        },
                        title: Text(
                          'Rome Ciampino',
                        ),
                        trailing: Text(
                          'CIA',
                          style: Theme.of(context).textTheme.subhead.copyWith(
                                color: Color(0xff8B8C98),
                              ),
                        ),
                      ),
                      index == 19 ? SizedBox.shrink() : Divider(),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screen.heightConverter(10)))
        ],
      ),
    );
  }
}
