import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/screens/out_bnv/auth/logic.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../validators.dart';

class EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authConstants = AuthConstants(context);
    var contentPaddingField = authConstants.contentPaddingField;
    var logic = Provider.of<AuthLogic>(context, listen: false);
    return MyTextField(
      'Email Address',
      // contentPadding: contentPaddingField,
      controller: logic.emailController,
      validator: TextFieldValidators(logic).email,
    );
  }
}
