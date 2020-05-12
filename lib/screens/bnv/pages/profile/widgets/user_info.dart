import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:provider/provider.dart';

import '../logic.dart';
import '../model.dart';
import 'info.dart';

class UserInfo extends StatelessWidget {
  final User user;
  UserInfo(this.user);
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var themeData = Theme.of(context);
    var logic = Provider.of<ProfileLogic>(context);
    var textTheme = themeData.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
              Radius.circular(screen.aspectRatioConverter(10))),
          child: Image.network(
            user.avatar,
            height: screen.heightConverter(100),
            width: screen.widthConverter(90),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
          left: screen.widthConverter(11),
        )),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: textTheme.body2,
              ),

              // Spacer(
              //   flex: 2,
              // ),

              // Spacer(
              //   flex: 1,
              // ),
              InfoLine(
                iconData: Icons.email,
                text: user.email,
              ),
              // Spacer(
              //   flex: 1,
              // ),
            ],
          ),
        )
      ],
    );
  }
}

class UserInfoLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
