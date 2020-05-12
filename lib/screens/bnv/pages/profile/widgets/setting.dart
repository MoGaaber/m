import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback onTap;
  SettingTile(this.title, this.trailing, this.onTap);
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    return Column(
      children: <Widget>[
        ListTile(
            onTap: this.onTap,
            contentPadding:
                EdgeInsets.symmetric(vertical: screen.heightConverter(10)),
            title: Text(
              title,
            ),
            trailing: trailing),
        Divider(
          height: 0,
          color: Color(0xffEEEEEE),
        )
      ],
    );
  }
}
/*
  Widget trailingWidget(BuildContext context) {
    var screen = Provider.of(context);

    if (kind == Kind.switcher) {
      return CupertinoSwitch(value: true, onChanged: (x) {});
    } else if (kind == Kind.text) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'English',
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Color(0xff90919D)),
          ),
          Padding(padding: EdgeInsets.only(left: screen.widthConverter(9))),
          Icon(
            Icons.arrow_forward_ios,
            size: screen.heightConverter(26),
            color: Theme.of(context).accentColor,
          )
        ],
      );
    } else {
      return Icon(
        Icons.arrow_forward_ios,
        size: screen.heightConverter(26),
        color: Theme.of(context).accentColor,
      );
    }
  }
*/
