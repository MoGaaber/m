import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/screens/out_bnv/auth/constants.dart';
import 'package:provider/provider.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FormFieldValidator<String> validator;
  final VoidCallback onTabTrailling;
  final bool obscureText;
  String hintText;
  PasswordTextField(
      {@required this.textEditingController,
      @required this.obscureText,
      @required this.hintText,
      @required this.onTabTrailling,
      this.validator});

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context).locale.languageCode;
    Screen screen = Provider.of(context);
    return MyTextField(
      hintText,
      // contentPadding: AuthConstants(context).contentPaddingField.add(
      //     EdgeInsets.only(
      //         right: localization == 'en' ? screen.widthConverter(40) : 0,
      //         left: localization == 'en' ? 0 : screen.widthConverter(40))),
      obscureText: this.obscureText,
      controller: this.textEditingController,
      helperText: null,

      onTapTrailling: () {
        onTabTrailling();
      },
      trailling:
          Icon(!obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
      validator: validator,
    );
  }
}
