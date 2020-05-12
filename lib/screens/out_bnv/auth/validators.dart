import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:m/screens/out_bnv/auth/logic.dart';
import 'package:provider/provider.dart';

typedef String Password(String input);

class TextFieldValidators {
  AuthLogic authLogic;
  TextFieldValidators(this.authLogic);
  String email(
    String input,
  ) {
    bool isValid = EmailValidator.validate(input);
    if (!isValid) {
      return 'Invalid email Address';
    }
    print('!!!');
    if (AuthLogic.email == authLogic.emailController.text) {
      return 'change This Email First';
    }
  }

  String password(
    String input,
  ) {
    if (input.length < 8) {
      return 'must be greater than 8 letters';
    }
  }

  String passwordConfirmation(
    String input,
  ) {
    if (authLogic.passwordController.text !=
        authLogic.passwordConfirmationController.text) {
      return 'password not identical';
    }
  }
}
