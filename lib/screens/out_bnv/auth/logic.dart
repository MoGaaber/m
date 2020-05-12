import 'dart:wasm';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/main.dart';
import 'package:m/screens/bnv/pages/profile/model.dart';
import 'package:m/screens/out_bnv/auth/ui/login.dart';
import 'package:progress_dialog/progress_dialog.dart';

typedef Map<String, dynamic> MessageHandler(Map<String, dynamic> result);
typedef void PasswordType();
typedef Future SuccessAction(x);

class AuthLogic with ChangeNotifier {
  BuildContext context;
  static final loginFormKey = GlobalKey<FormState>();
  static final registerFormKey = GlobalKey<FormState>();
  static final forgetPasswordFormKey = GlobalKey<FormState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final test = TextEditingController();

  var obscurePassword = true;
  var obscurePasswordConfirmation = true;
  static Map<String, dynamic> signUpForm;
  static Map<String, dynamic> signInForm;
  String avatarPath;
  static String email;
  static ProgressDialog progressDialog;

  AuthLogic(this.context);
  static void setProgressDialog(BuildContext context) =>
      progressDialog = ProgressDialog(context);

  void toogleObscure() {
    obscurePassword = !obscurePassword;
  }

  void toogleObscureConfirmation() {
    obscurePasswordConfirmation = !obscurePasswordConfirmation;
  }

  void onTapEye(PasswordType passwordType) {
    passwordType();
    notifyListeners();
  }

  static Future postForm(Map<String, dynamic> form, String apiUrl) async {
    FormData formData = new FormData.fromMap(form);
    try {
      var response = await Dio().post(
        apiUrl,
        data: formData,
      );
      return response.data;
    } catch (e) {
      DioError dioError = e;
      return dioError.response.data;
    }
  }

  waitForName(GlobalKey<FormState> formKey, Map<String, dynamic> form,
      String api, MessageHandler messageHandler, SuccessAction action) async {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      // await progressDialog.show();
      var result = await postForm(form, api);
      // await progressDialog.hide();

      if (result.containsKey('success')) {
        // showSnackBar('successful', Colors.green);
        action(result);
      } else {
        var message = messageHandler(result);
        showSnackBar(message['message'], message['color']);
      }
    }
  }

  Future<void> register() async {
    waitForName(registerFormKey, await registerForm(), ApisUrls.signUp,
        registerMessageHandler, (x) {
      toLoginPage();
    });
  }

  void toLoginPage() {
    Navigator.pushReplacementNamed(this.context, Login.route);
  }

  void login() => waitForName(
          loginFormKey,
          {
            'email': emailController.text,
            'password': passwordController.text,
          },
          ApisUrls.signIn,
          loginMessageHandler, (x) async {
        var info = User.fromJsonAfterLogin(x['success'], emailController.text);
        await sharedPreferences.setString('token', info.token);
        await sharedPreferences.setBool('isLoggedIn', true);

        Navigator.pop(this.context, info);
      });

  void forgetPassword() => waitForName(
          forgetPasswordFormKey,
          {'email': emailController.text},
          ApisUrls.resetPassword,
          forgetPasswordMessageHandler, (x) {
        toLoginPage();
      });

  Future<Map<String, dynamic>> registerForm() async {
    Map<String, dynamic> form = {
      'fname': fNameController.text,
      'lname': lNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmationController.text
    };
    if (this.avatarPath != null) {
      form.addAll(
        {
          'avatar': await MultipartFile.fromFile(avatarPath,
              filename: avatarPath.split('/').last)
        },
      );
    }
    return form;
  }

  static Map<String, dynamic> loginMessageHandler(
      Map<String, dynamic> message) {
    return {'message': 'Recheck your Email and password', 'color': Colors.red};
  }

  static Map<String, dynamic> forgetPasswordMessageHandler(
      Map<String, dynamic> message) {
    return {'message': 'Recheck your Email ', 'color': Colors.red};
  }

  static Map<String, dynamic> registerMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('success')) {
      return {'message': 'Successful registration', 'color': Colors.green};
    } else {
      Map<String, dynamic> errorMessage = message['error'];

      if (errorMessage.containsKey('email')) {
        return {
          'message': 'Email address is Already Taken',
          'color': Colors.red
        };
      }
      return {
        'message': 'Something went wrong . Try again',
        'color': Colors.red
      };
    }
  }

  Future<void> pickAvatar() async {
    avatarPath = await FilePicker.getFilePath(type: FileType.image);
    notifyListeners();
  }

  void removeSelectedAvatar() {
    avatarPath = null;
    notifyListeners();
  }

  void showSnackBar(String message, Color color) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}
/*
  static void showSuccessSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  static void showFailSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

*/
