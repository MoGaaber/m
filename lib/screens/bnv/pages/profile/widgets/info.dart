import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:provider/provider.dart';

class InfoLine extends StatelessWidget {
  final String text;
  final IconData iconData;
  InfoLine({this.text, this.iconData});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    print(textTheme.subtitle.fontSize);
    print('hello');
    print(text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.green,
          ),
          Spacer(),
          Expanded(
              flex: 40,
              child: Text(
                text,
                // overflowReplacement: Text('...'),

                // overflow: TextOverflow.ellipsis,
                //     softWrap: true,

                // maxLines: null,

                // maxLines: 1,
                style: textTheme.subtitle,
                // maxLines: 1,
              ))
        ],
      ),
    );
  }
}
