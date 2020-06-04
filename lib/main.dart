import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/screens/bnv/pages/check_out/ui.dart';
import 'package:m/screens/out_bnv/book_flight/logic.dart';
import 'package:m/screens/out_bnv/full_screen_map/full_screen_map.dart';
import 'package:m/screens/out_bnv/language/logic.dart';
import 'package:m/screens/out_bnv/photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import 'commons/utils/localization/delegate.dart';
import 'commons/utils/localization/localization.dart';
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
      create: (BuildContext context) => BookFlightLogic(),
      child: BookFlight(),
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
    var languageCode = sharedPreferences.getString('languageCode');

    return MaterialApp(
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
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xff005C15),
        primaryColor: Colors.white,
        canvasColor: Color(0xffF5F5F5),
        dividerColor: Color(0xff2E0E0E1),
        primaryColorDark: Color(0xff24253D),
        primaryColorLight: Color(0xff91919D),
      ),
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
    var isAr = Localization.of(context).locale.languageCode == 'ar';
    var arabicFontFamily = GoogleFonts.tajawal().fontFamily;
    var myCommontTextStyle = TextStyle(
      fontFamily: isAr ? arabicFontFamily : 'SFUIText',
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
        Countries.route: (_) => Countries(),
        MyMap.route: (_) => FullScreenMap(),
        Splash.route: (_) => Splash(),
        MoreRoot.route: (_) => MoreRoot(),
        InfoRoot.route: (_) => InfoRoot(),
        BnvRoot.route: (_) => BnvRoot(),
        SignUp.route: (_) => SignUp(),
        Login.route: (_) => Login(),
        CheckOutRoot.route: (_) => CheckOutRoot(),
        BookFlight.route: (_) => BookFlight(),
        ForgetPassword.route: (_) => ForgetPassword(),
        Filter.route: (_) => Filter(),
        Language.route: (_) => Language(),
        MyPhotoView.route: (_) => MyPhotoView(),
        Test.route: (_) => Test(),
        MyWebView.route: (_) => MyWebView()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: Countries.route,
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
                fontFamily: isAr ? arabicFontFamily : 'OpenSans',
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
          height: screen.heightConverter(50),
          // minWidth: screen.widthConverter(300),
          colorScheme: ColorScheme.light(primary: Colors.green),
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  static const route = 'test';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var respose = await Dio().post(
          'https://secure.innovatepayments.com/gateway/mobile.xml',
          data: (''' 
          <?xml version="1.0" encoding="UTF-8"?>
<mobile>
  <store>23065</store>
  <key>QTtww-nKJG#MvXqC</key> 
  <device>
    <type>hello</type>
    <id>world</id>
  </device>
  <app>
    <name>test</name>
    <version>2</version>
    <user>what</user>
    <id>why</id>
  </app>
  <tran>
    <test>1</test>
    <type>paypage</type>
    <class>cont</class>
    <cartid>444444</cartid>
    <description>uuuuuu</description>
    <currency>sar</currency>
    <amount>200.00</amount>
    <ref></ref>
  </tran>
  <billing>
    <name>
      <title>mmm</title>
      <first>Mohamed</first>
      <last>Gaber</last>
    </name>
    <address>
      <line1>Street address – line 1 (Note 13)</line1>
      <line2>Street address – line 2</line2>
      <line3>Street address – line 3</line3>
      <city>alexanderia</city>
      <region>agamy</region>
      <country>EG</country>
      <zip>555457</zip>
    </address>
    <email>mohamedgaber523@gmail.com</email>
  </billing>
</mobile>


'''),
          options: Options(
              headers: {'Content-Type': 'application/xml'},
              contentType: 'application/xml'),
        );
        print(respose.data);
        var xml = XmlDocument.parse(respose.data);
        var url = (xml
            .getElement('mobile')
            .getElement('webview')
            .getElement('start')
            .text);
        Navigator.pushNamed(context, MyWebView.route, arguments: url);
      }),
    );
  }
}

class MyWebView extends StatelessWidget {
  static const route = 'webview';
  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments;
    return WebviewScaffold(
      scrollBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.green,
        ),
      ),
      url: arguments,
      withJavascript: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
