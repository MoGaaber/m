import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:provider/provider.dart';

class MyGridCard extends StatelessWidget {
  final CompleteElementModel data;
  MyGridCard(this.data);

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    final theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, InfoRoot.route, arguments: data);
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(screen.widthConverter(10))),
                child: CachedNetworkImage(
                  imageUrl: data.mainImagePath,
                  fit: BoxFit.cover,
                  // width: screen.widthConverter(158),
                  // height: screen.heightConverter(100),
                ),
              ),
            ),
            Text(
              data.getTitle,
              style: textTheme.body2,
            ),

            // Text(
            //   data.getTitle,
            //   style: textTheme.body2,
            // ),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                r"$" + data.adultPrice,
                style: textTheme.body1.copyWith(color: Colors.green),
              ),
            ),

            // Text('4 of your friends like this spot friends like this spot',
            //     style: textTheme.body1.copyWith(
            //         fontFamily: 'RobotoSlab',
            //         color: Color(0xff5C6979),
            //         fontSize: ScreenUtil().setSp(10))),
            Padding(padding: EdgeInsets.only(top: 4)),

            // MyRatingBar(screen.heightConverter(14)),
          ]),
    );
  }
}
