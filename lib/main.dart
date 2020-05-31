import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/screens/out_bnv/full_screen_map/full_screen_map.dart';
import 'package:m/screens/out_bnv/language/logic.dart';
import 'package:m/screens/out_bnv/photo_view/photo_view.dart';

import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commons/utils/localization/delegate.dart';
import 'commons/utils/screen.dart';
import 'commons/widgets/map.dart';
import 'commons/widgets/scroll_behavior.dart';
import 'screens/bnv/widget/bnv.dart';
import 'screens/out_bnv/auth/ui/forget.dart';
import 'screens/out_bnv/auth/ui/login.dart';
import 'screens/out_bnv/auth/ui/register.dart';
import 'screens/out_bnv/book_flight/ui.dart';
import 'screens/out_bnv/filter/logic.dart';
import 'screens/out_bnv/filter/ui.dart';
import 'screens/out_bnv/info/ui.dart';
import 'screens/out_bnv/language/ui.dart';
import 'screens/out_bnv/more/ui.dart';
import 'screens/out_bnv/splash/ui.dart';

SharedPreferences sharedPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MultiProvider(child: ContextMateriaApp(), providers: [
    ChangeNotifierProvider(
      create: (BuildContext context) => LanguageLogic(),
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) => FilterLogic(),
    ),
    Provider(
      create: (_) => Screen(),
    ),
  ]));
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of<Screen>(context);
    ScreenUtil.init(context,
        height: screen.myHeight, width: screen.myWidth, allowFontScaling: true);
    var languageCode = sharedPreferences.getString('languageCode');
    screen.size = MediaQuery.of(context).size;
    ScreenUtil screenUtil = ScreenUtil();
    var myCommontTextStyle = TextStyle(
      fontFamily: 'SFUIText',
      fontWeight: FontWeight.w500,
      color: Color(0xff23243C),
      fontSize: screenUtil.setSp(17),
    );
    LanguageLogic languageLogic = Provider.of(context);
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        CompleteElementModel.context = context;

        return SafeArea(
          child: ScrollConfiguration(
            behavior: MyScrollBehavior(),
            child: child,
          ),
        );
      },
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: languageCode == null
          ? null
          : Locale.fromSubtags(languageCode: languageCode),
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ar', ''),
      ],
      routes: {
        MyMap.route: (_) => FullScreenMap(),
        Splash.route: (_) => Splash(),
        MoreRoot.route: (_) => MoreRoot(),
        InfoRoot.route: (_) => InfoRoot(),
        BnvRoot.route: (_) => BnvRoot(),
        SignUp.route: (_) => SignUp(),
        Login.route: (_) => Login(),
//        CheckOut.route: (_) => CheckOut(),
        BookFlightRoot.route: (_) => BookFlightRoot(),
        ForgetPassword.route: (_) => ForgetPassword(),
        Filter.route: (_) => Filter(),
        Language.route: (_) => Language(),
        MyPhotoView.route: (_) => MyPhotoView()
      },
      debugShowCheckedModeBanner: false,
      title: 'Touri',
      initialRoute: BnvRoot.route,
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
            body1: myCommontTextStyle.copyWith(fontSize: screenUtil.setSp(13)),
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
          // minWidth: screen.widthConverter(300),
          colorScheme: ColorScheme.light(primary: Colors.green),
        ),
      ),
    );
  }
}
