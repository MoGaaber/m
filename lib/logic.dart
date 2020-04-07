import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/forget.dart';
import 'package:m/main.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static const route = '/login';
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return UserRegistirationRoot(
      'Sign in',
      Column(
        children: <Widget>[
          MyTextField('Email Address'),
          MyTextField('Password'),
        ],
      ),
      'Sign in',
      () {},
      extra: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ForgetPassword.route);
        },
        child: Text(
          'Forget password',
          style: textTheme.body1.copyWith(color: theme.primaryColorDark),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  String hintText;
  Widget trailling;
  EdgeInsetsGeometry contentPadding;
  Color color;
  List<BoxShadow> shadow;
  Widget prefixIcon;
  VoidCallback onTap;
  bool readOnly;

  MyTextField(this.hintText,
      {this.contentPadding,
      this.trailling,
      this.onTap,
      this.color = const Color(0xfff3f3f4),
      this.shadow,
      this.readOnly = false,
      this.prefixIcon});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var textScale = MediaQuery.of(context).textScaleFactor;
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ScreenUtil.init(context,
        height: screen.myHeight, width: screen.myWidth, allowFontScaling: true);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screen.heightConverter(10)),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: shadow,
            borderRadius: BorderRadius.all(
                Radius.circular(screen.aspectRatioConverter(10)))),
        child: Stack(
          children: <Widget>[
            TextField(
                onTap: onTap,
                readOnly: readOnly,
                decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  contentPadding: this.contentPadding,
                  hintText: this.hintText,
                  fillColor: this.color,
                  filled: true,
                  hintStyle: textTheme.body1.copyWith(
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8B8C98),
                      fontSize: ScreenUtil().setSp(14)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                )),
            Positioned.fill(
              child: Align(
                  alignment: Alignment(1, 0),
                  child: Padding(
                      padding:
                          EdgeInsets.only(right: screen.widthConverter(10)),
                      child: trailling)),
            )
          ],
        ),
      ),
    );
  }
}

/*


*/
