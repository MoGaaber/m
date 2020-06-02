import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/email.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/password.dart';
import 'package:provider/provider.dart';

import '../logic.dart';
import '../validators.dart';

class SignUp extends StatelessWidget {
  static const route = '/signup';

  @override
  Widget build(BuildContext context) {
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
                          heroTag: 'ss',
                          onPressed: () {
                            logic.fNameController.text = 'h';
                            logic.lNameController.text = 'h';

                            logic.emailController.text = 'hhh@yahoo.com';
                            logic.passwordController.text = 'gaber123';
                            logic.passwordConfirmationController.text =
                                'gaber123';
                          }),
                      key: AuthLogic.scaffoldKey,
                      appBar: AppBar(),
                      body: Form(
                        key: AuthLogic.registerFormKey,
                        child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: screen.widthConverter(20.5)),
                            children: <Widget>[
                              Text(
                                localization[2],
                                style: textTheme.display2,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screen.heightConverter(23)),
                                  child: Selector<AuthLogic, String>(
                                    builder: (_, String value, __) => Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Container(
                                          height: screen.heightConverter(150),
                                          width: screen.widthConverter(200),
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(screen
                                                      .aspectRatioConverter(
                                                          10))),
                                              child: value == null
                                                  ? Image.asset(
                                                      'assets/images/user.png',
                                                      color: Color(0xff8B8C98),
                                                      height: screen
                                                          .heightConverter(140),
                                                      width: screen
                                                          .widthConverter(140),
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.file(
                                                      File(value),
                                                      fit: BoxFit.cover,
                                                      height: screen
                                                          .heightConverter(140),
                                                      width: screen
                                                          .widthConverter(140),
                                                    ),
                                            ),
                                          ),
                                        ),
                                        value == null
                                            ? Positioned(
                                                height:
                                                    screen.heightConverter(30),
                                                top: 0,
                                                right: 0,
                                                child: FloatingActionButton(
                                                  onPressed: () {
                                                    logic.pickAvatar();
                                                  },
                                                  child: Icon(Icons.add),
                                                ),
                                              )
                                            : Positioned(
                                                top: screen.heightConverter(-5),
                                                right:
                                                    screen.widthConverter(13),
                                                height:
                                                    screen.heightConverter(30),
                                                child: FloatingActionButton(
                                                  onPressed: () {
                                                    logic
                                                        .removeSelectedAvatar();
                                                  },
                                                  backgroundColor: Colors.red,
                                                  child: Icon(Icons.close),
                                                ),
                                              )
                                      ],
                                    ),
                                    selector: (_, AuthLogic signUpLogic) =>
                                        signUpLogic.avatarPath,
                                  ),
                                ),
                              ),
                              MyTextField(
                                localization[4],
                                // contentPadding: contentPaddingField,
                                controller: logic.fNameController,
                              ),
                              MyTextField(
                                localization[5],
                                // contentPadding: contentPaddingField,
                                controller: logic.lNameController,
                              ),
                              EmailTextField(),
                              Selector<AuthLogic, bool>(
                                builder: (BuildContext context, bool value,
                                        Widget child) =>
                                    PasswordTextField(
                                  hintText: localization[7],
                                  onTabTrailling: () {
                                    logic.onTapEye(logic.toogleObscure);
                                  },
                                  validator:
                                      TextFieldValidators(context).password,
                                  textEditingController:
                                      logic.passwordController,
                                  obscureText: logic.obscurePassword,
                                ),
                                selector: (_, AuthLogic signUpLogic) =>
                                    signUpLogic.obscurePassword,
                              ),
                              Selector<AuthLogic, bool>(
                                builder: (BuildContext context, bool value,
                                        Widget child) =>
                                    PasswordTextField(
                                  hintText: localization[8],
                                  onTabTrailling: () {
                                    logic.onTapEye(
                                        logic.toogleObscureConfirmation);
                                  },
                                  obscureText: value,
                                  validator: TextFieldValidators(context)
                                      .passwordConfirmation,
                                  textEditingController:
                                      logic.passwordConfirmationController,
                                ),
                                selector: (_, AuthLogic signUpLogic) =>
                                    signUpLogic.obscurePasswordConfirmation,
                              ),
                              Padding(
                                  child: FlatButton(
                                    onPressed: () {
                                      logic.register(context);
                                    },
                                    child: Text(
                                      localization[1],
                                      style: textTheme.button,
                                    ),
                                    color: themeData.accentColor,
                                  ),
                                  padding: EdgeInsets.only(
                                      top: screen.heightConverter(33.5),
                                      bottom: screen.heightConverter(50.5)))
                            ]),
                      )))),
    );
  }
}
