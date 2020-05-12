import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/email.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/password.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../logic.dart';
import 'forget.dart';

class Login extends StatelessWidget {
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Screen screen = Provider.of(context);
    ThemeData themeData = Theme.of(context);
    TextTheme textTheme = themeData.textTheme;

    return ChangeNotifierProvider(
        create: (BuildContext context) => AuthLogic(context),
        child: Consumer<AuthLogic>(
          builder: (BuildContext ctx, AuthLogic logic, Widget child) =>
              SafeArea(
                  child: Scaffold(
                      floatingActionButton: FloatingActionButton(onPressed: () {
                        logic.emailController.text = 'hhh@yahoo.com';
                        logic.passwordController.text = 'gaber123';
                      }),
                      key: AuthLogic.scaffoldKey,
                      appBar: AppBar(),
                      body: Form(
                        key: AuthLogic.loginFormKey,
                        child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: screen.widthConverter(20.5)),
                            children: <Widget>[
                              Text(
                                'Sign in',
                                style: textTheme.display2,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screen.heightConverter(23))),
                              EmailTextField(),
                              PasswordTextField(
                                onTabTrailling: () {},
                                textEditingController: logic.passwordController,
                                obscureText: logic.obscurePassword,
                              ),
                              Padding(
                                  child: FlatButton(
                                    onPressed: logic.login,
                                    child: Text('Sign in'),
                                    color: themeData.accentColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: screen.heightConverter(33.5))),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ForgetPassword.route);
                                  },
                                  child: Text(
                                    'Forget password',
                                    style: textTheme.body1.copyWith(
                                        color: theme.primaryColorDark),
                                  ),
                                ),
                              ),
                            ]),
                      ))),
        ));
  }
}
