import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';

class ArrowWithText extends StatelessWidget {
  final String title;

  ArrowWithText(this.title);
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          this.title,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: Color(0xff90919D)),
        ),
        Padding(padding: EdgeInsets.only(left: screen.widthConverter(9))),
        Arrow()
      ],
    );
  }
}

class Arrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);

    return Icon(
      Icons.arrow_forward_ios,
      size: screen.heightConverter(14),
      color: Theme.of(context).accentColor,
    );
  }
}
