import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/screens/out_bnv/auth/logic.dart';
import 'package:provider/provider.dart';

typedef String Password(String input);

class TextFieldValidators {
  AuthLogic authLogic;
  BuildContext context;
  List<String> localization;
  TextFieldValidators(this.context) {
    authLogic = Provider.of(context, listen: false);
    localization = Localization.of(context).auth;
  }
  String email(
    String input,
  ) {
    bool isValid = EmailValidator.validate(input);
    if (!isValid) {
      return localization[10];
    }
    // if (AuthLogic.email == authLogic.emailController.text) {
    //   return 'change This Email First';
    // }
  }

  String password(
    String input,
  ) {
    if (input.length < 8) {
      return localization[11];
    }
  }

  String passwordConfirmation(
    String input,
  ) {
    if (authLogic.passwordController.text !=
        authLogic.passwordConfirmationController.text) {
      return localization[12];
    }
  }
}
