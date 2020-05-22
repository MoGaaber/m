import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/screens/out_bnv/auth/logic.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/email.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  static const route = 'forget';

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    ThemeData themeData = Theme.of(context);
    var localization = Localization.of(context).auth;

    return ChangeNotifierProvider(
      create: (_) => AuthLogic(context),
      child: Consumer<AuthLogic>(
        builder: (BuildContext context, AuthLogic logic, Widget child) =>
            SafeArea(
                child: Scaffold(
          key: AuthLogic.scaffoldKey,
          appBar: AppBar(),
          body: Form(
            key: AuthLogic.forgetPasswordFormKey,
            child: ListView(
              padding:
                  EdgeInsets.symmetric(horizontal: screen.widthConverter(20.5)),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screen.heightConverter(33.5)),
                  child: EmailTextField(),
                ),
                FlatButton(
                  onPressed: () {
                    logic.forgetPassword(context);
                  },
                  child: Text(localization[13]),
                  color: themeData.accentColor,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
