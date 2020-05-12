import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/filter/ui.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return AppBar(
      elevation: 2,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screen.widthConverter(10)),
          child: IconButton(
              icon: Icon(
                FontAwesomeIcons.slidersH,
                color: Color(0xff323B45),
                size: screen.heightConverter(15),
              ),
              onPressed: () {
                Navigator.pushNamed(context, Filter.route);
              }),
        )
      ],
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.fitHeight,
//            width: 40,
        height: screen.heightConverter(21),
      ),
      // title: Text('Touri'),
    );
  }
}
