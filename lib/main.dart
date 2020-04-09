import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/info.dart';

import 'package:m/logic.dart';

import 'package:m/profile.dart';

import 'package:m/screen.dart';

import 'package:m/search.dart';

import 'package:m/sign_up.dart';

import 'package:m/splash.dart';

import 'package:m/trips.dart';

import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splashscreen/splashscreen.dart';

import 'bnv.dart';

import 'book_flight.dart';

import 'check_out.dart';

import 'filter.dart';

import 'find_flight.dart';

import 'forget.dart';

import 'info_logic.dart';

import 'language.dart';

import 'more.dart';

BuildContext globalContext;

void main() {
  runApp(Provider(
    child: ContextMateriaApp(),
    create: (_) => Screen(),
  ));
}

class MyApp extends StatelessWidget {
  Screen screen;
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    Screen screen = Provider.of<Screen>(context);
    screen.size = MediaQuery.of(context).size;
    screen.mediaQueryData = MediaQuery.of(context);

    ScreenUtil.init(context,
        height: screen.myHeight, width: screen.myWidth, allowFontScaling: true);
    print(ScreenUtil().setSp(20));
    ScreenUtil screenUtil = ScreenUtil();
    var myCommontTextStyle = TextStyle(
      fontFamily: 'SFUIText',
      fontWeight: FontWeight.w500,
      color: Color(0xff23243C),
      fontSize: screenUtil.setSp(17),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InfoLogic(),
        )
      ],
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: MaterialApp(
          routes: {
            Splash.route: (_) => Splash(),
            Search.route: (_) => Search(),
            More.route: (_) => More(),
            Info.route: (_) => Info(),
            Bnv.route: (_) => Bnv(),
            SignUp.route: (_) => SignUp(),
            Login.route: (_) => Login(),
            CheckOut.route: (_) => CheckOut(),
            BookFlight.route: (_) => BookFlight(),
            ForgetPassword.route: (_) => ForgetPassword(),
            Filters.route: (_) => Filters(),
            LanguageSelect.route: (_) => LanguageSelect()
          },
          builder: (BuildContext buildContext, Widget widget) {
            return widget;
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: Splash.route,
          theme: ThemeData(
            textTheme: TextTheme(
                overline: myCommontTextStyle.copyWith(
                    letterSpacing: 0,
                    fontSize: screenUtil.setSp(10),
                    color: Color(0xff005C15)),
                caption: myCommontTextStyle.copyWith(
                  fontSize: screenUtil.setSp(14),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                subtitle: myCommontTextStyle.copyWith(
                    color: Color(0xff91919D), fontSize: screenUtil.setSp(12)),
                subhead: myCommontTextStyle,
                button: myCommontTextStyle.copyWith(color: Colors.white),
                body2: myCommontTextStyle.copyWith(fontWeight: FontWeight.w700),
                body1:
                    myCommontTextStyle.copyWith(fontSize: screenUtil.setSp(13)),
                display2: TextStyle(
                    color: Color(0xff24253D),
                    fontSize: screenUtil.setSp(28),
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500)),
            accentColor: Color(0xff005C15),
            primaryColor: Colors.white,
            canvasColor: Color(0xffF5F5F5),
            dividerColor: Color(0xff2E0E0E1),
            primaryColorDark: Color(0xff24253D),
            primaryColorLight: Color(0xff91919D),
            dialogTheme: DialogTheme(),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  display2: TextStyle(
                fontSize: screenUtil.setSp(28),
                fontFamily: 'OpenSans',
                color: Colors.white,
              )),
              iconTheme: IconThemeData(color: Color(0xff005C15), size: 50),
              elevation: 0,
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: screen.heightConverter(70),
              colorScheme: ColorScheme.light(primary: Colors.green),
            ),
          ),
        ),
      ),
    );
  }
}

class ContextMateriaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xff005C15),
        primaryColor: Colors.white,
        canvasColor: Color(0xffF5F5F5),
        dividerColor: Color(0xff2E0E0E1),
        primaryColorDark: Color(0xff24253D),
        primaryColorLight: Color(0xff91919D),
      ),
      home: MyApp(),
    );
  }
}
