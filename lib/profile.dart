import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/forget.dart';
import 'package:m/info.dart';
import 'package:m/language.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var textTheme = Theme.of(context).textTheme;
    print(screen.width);
    return UserRegistirationRoot(
      'Profile',
      Column(children: <Widget>[
        SizedBox.fromSize(
          size: Size.fromHeight(screen.heightConverter(100)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Container(

              //   width: screen.widthConverter(90),
              //   height: screen.heightConverter(90),
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           fit: BoxFit.cover,
              //            )),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(screen.aspectRatioConverter(10))),
                child: Image.network(
                  'https://images.unsplash.com/photo-1536548665027-b96d34a005ae?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                  width: screen.widthConverter(90),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                left: screen.widthConverter(11),
              )),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: screen.heightConverter(6)),
                      child: Text(
                        'Robert Annin',
                        style: textTheme.body2,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    ProfileInfoLine(
                      text: 'Brasov, Romania',
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    ProfileInfoLine(
                      text: 'contact@robertanitei.com',
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: screen.heightConverter(35))),
        ProfileInfoListTile('Language', ArrowWithTrailing('English'), () {
          Navigator.pushNamed(context, LanguageSelect.route);
        }),
        ProfileInfoListTile('Currency', ArrowWithTrailing('USD'), () {}),
        ProfileInfoListTile(
            'Currency', CupertinoSwitch(value: true, onChanged: (x) {}), () {}),
        ProfileInfoListTile('Units', ArrowWithTrailing('Imperial'), () {}),
        ProfileInfoListTile('Privacy Policy', Arrow(), () {}),
        Padding(padding: EdgeInsets.only(top: screen.heightConverter(20))),
      ]),
      'Sign out',
      () {},
      textColor: Theme.of(context).accentColor,
      buttonColor: Color(0xffF5F5F5),
    );
  }
}

class ArrowWithTrailing extends StatelessWidget {
  String title;

  ArrowWithTrailing(this.title);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var textTheme = Theme.of(context).textTheme;

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
    Screen screen = Provider.of(context);

    return Icon(
      Icons.arrow_forward_ios,
      size: screen.heightConverter(26),
      color: Theme.of(context).accentColor,
    );
  }
}

class ProfileInfoLine extends StatelessWidget {
  String text;
  IconData iconData;
  ProfileInfoLine({this.text, this.iconData});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var textTheme = Theme.of(context).textTheme;

    print('hello');
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: Colors.green,
        ),
        Padding(padding: EdgeInsets.only(left: screen.widthConverter(7))),
        Text(text, style: textTheme.subtitle)
      ],
    );
  }
}

enum Kind { switcher, text, none }

class ProfileInfoListTile extends StatelessWidget {
  Kind kind;
  String title;
  Widget trailing;
  VoidCallback onTap;
  ProfileInfoListTile(this.title, this.trailing, this.onTap);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return Column(
      children: <Widget>[
        ListTile(
            onTap: this.onTap,
            title: Text(
              title,
            ),
            trailing: trailing),
        Divider(
          color: Color(0xffEEEEEE),
        )
      ],
    );
  }

  Widget trailingWidget(BuildContext context) {
    Screen screen = Provider.of(context);

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
}
