import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:provider/provider.dart';

class InfoLine extends StatelessWidget {
  final IconData iconData;
  final Widget child;
  InfoLine({this.iconData, this.child});
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);

    var textTheme = Theme.of(context).textTheme;
    print(textTheme.subtitle.fontSize);
    print('hello');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          color: Colors.green,
        ),
        Padding(
            padding: EdgeInsets.only(right: screen.widthConverter(10)),
            child: child)
      ],
    );
  }
}
