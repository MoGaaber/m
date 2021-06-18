import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/auth/validators.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/email.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/password.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class Login extends StatelessWidget {
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Screen screen = Provider.of(context);
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;
    var localization = Localization.of(context).auth;

    return ChangeNotifierProvider(
        create: (_) => AuthLogic(context),
        child: Consumer<AuthLogic>(
          builder: (BuildContext context, AuthLogic logic, Widget child) =>
              SafeArea(
                  child: Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () async {
                          logic.emailController.text = 'moohammed.gaber@gmail.com';
                          logic.passwordController.text = '12345678';
                        },
                        heroTag: '!fds',
                      ),
                      key: AuthLogic.loginKey,
                      appBar: AppBar(),
                      body: Form(
                        key: AuthLogic.loginFormKey,
                        child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: screen.widthConverter(20.5)),
                            children: <Widget>[
                              Text(
                                localization[0],
                                style: textTheme.display2,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screen.heightConverter(23))),
                              EmailTextField(),
                              PasswordTextField(
                                validator:
                                    TextFieldValidators(context).password,
                                hintText: localization[7],
                                onTabTrailling: () {},
                                textEditingController: logic.passwordController,
                                obscureText: logic.obscurePassword,
                              ),
                              Padding(
                                  child: FlatButton(
                                    onPressed: () {
                                      logic.login(context);
                                    },
                                    child: Text(localization[0]),
                                    color: themeData.accentColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: screen.heightConverter(33.5))),
                              // Center(
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       Navigator.pushNamed(
                              //           context, ForgetPassword.route);
                              //     },
                              //     child: Text(
                              //       localization[3],
                              //       style: textTheme.body1.copyWith(
                              //           color: theme.primaryColorDark),
                              //     ),
                              //   ),
                              // ),
                            ]),
                      ))),
        ));
  }
}
