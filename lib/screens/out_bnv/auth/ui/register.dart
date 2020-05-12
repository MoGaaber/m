import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/out_bnv/auth/constants.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/email.dart';
import 'package:m/screens/out_bnv/auth/widgets/text_fields/password.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
    AuthLogic.setProgressDialog(context);
    var authConstants = AuthConstants(context);
    var contentPaddingField = authConstants.contentPaddingField;
    var localization = Localization.of(context);
    var languageCode = localization.langugeCode;
    return ChangeNotifierProvider(
      create: (_) => AuthLogic(context),
      child: Consumer<AuthLogic>(
          builder: (BuildContext context, AuthLogic logic, Widget child) =>
              SafeArea(
                  child: Scaffold(
                      key: AuthLogic.scaffoldKey,
                      appBar: AppBar(),
                      body: Form(
                        key: AuthLogic.registerFormKey,
                        child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: screen.widthConverter(20.5)),
                            children: <Widget>[
                              Text(
                                'Create new account',
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
                                          decoration: BoxDecoration(

                                              // boxShadow: [
                                              // BoxShadow(
                                              //     blurRadius: screen.heightConverter(20),
                                              //     spreadRadius: screen.heightConverter(5),
                                              //     color: Colors.grey.withOpacity(0.5))
                                              // ], shape: BoxShape.circle
                                              ),
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
                                        // AvatarIcon(
                                        //     Icons.cancel,
                                        //     Colors.red,
                                        //     () => logic.removeSelectedAvatar(),
                                        //     -50,
                                        //     -15),
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
                                'First Name',
                                // contentPadding: contentPaddingField,
                                controller: logic.fNameController,
                              ),
                              MyTextField(
                                'Last Name',
                                // contentPadding: contentPaddingField,
                                controller: logic.lNameController,
                              ),
                              EmailTextField(),
                              Selector<AuthLogic, bool>(
                                builder: (BuildContext context, bool value,
                                        Widget child) =>
                                    PasswordTextField(
                                  onTabTrailling: () {
                                    logic.onTapEye(logic.toogleObscure);
                                  },
                                  validator:
                                      TextFieldValidators(logic).password,
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
                                  onTabTrailling: () {
                                    logic.onTapEye(
                                        logic.toogleObscureConfirmation);
                                  },
                                  obscureText: value,
                                  validator: TextFieldValidators(logic)
                                      .passwordConfirmation,
                                  textEditingController:
                                      logic.passwordConfirmationController,
                                ),
                                selector: (_, AuthLogic signUpLogic) =>
                                    signUpLogic.obscurePasswordConfirmation,
                              ),
                              Padding(
                                  child: FlatButton(
                                    onPressed: logic.register,
                                    child: Text(
                                      'Sign up',
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
