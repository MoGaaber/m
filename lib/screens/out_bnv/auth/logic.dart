import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/models/dio_response.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/methods.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/main.dart';
import 'package:m/screens/bnv/pages/profile/model.dart';
import 'package:m/screens/out_bnv/auth/ui/login.dart';

typedef String MessageHandler(BuildContext context);
typedef void PasswordType();
typedef void SuccessAction(x);

class AuthLogic with ChangeNotifier {
  static final loginFormKey = GlobalKey<FormState>();
  static final registerFormKey = GlobalKey<FormState>();
  static final forgetPasswordFormKey = GlobalKey<FormState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  static final loginKey = GlobalKey<ScaffoldState>();

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
  BuildContext context;
  static List<String> localization;
  AuthLogic(this.context) {
    localization = Localization.of(context).auth;
  }

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

  static Future<AuthDioResponse> postForm(
      BuildContext context, Map<String, dynamic> form, String apiUrl) async {
    // Methods(context).showProgressDialog();
    // Methods(context).hideProgressDialog();

    FormData formData = new FormData.fromMap(form);
    try {
      var response = await Dio().post(
        apiUrl,
        data: formData,
      );
      return AuthDioResponse(200, response: response.data);
    } catch (e) {
      DioError dioError = e;
      return AuthDioResponse(dioError.response?.statusCode);
    }
  }

  Future<void> waitForName(
    BuildContext context,
    GlobalKey<FormState> formKey,
    Map<String, dynamic> form,
    String api,
    MessageHandler messageHandler,
    SuccessAction action,
  ) async {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      var response = await postForm(context, form, api);
      var responseStatusCode = response.statusCode;
      if (responseStatusCode == 200) {
        action(response.response['success']);
      } else if (responseStatusCode == null) {
        showSnackBar(localization[15]);
      } else if (responseStatusCode == 401) {
        showSnackBar(messageHandler(context));
      } else {
        showSnackBar(localization[14]);
      }
    }
  }

  Future<void> register(BuildContext context) async {
    Methods methods = Methods(context);
    await methods.showProgressDialog();
    await waitForName(context, registerFormKey, await registerForm(),
        ApisUrls.signUp, registerMessageHandler, (x) async {
      Navigator.pop(context);
    });
    await methods.hideProgressDialog();
  }

  void toLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, Login.route);
  }

  Future<void> login(BuildContext context) async {
    Methods methods = Methods(context);
    await methods.showProgressDialog();

    await waitForName(
        context,
        loginFormKey,
        {
          'email': emailController.text,
          'password': passwordController.text,
        },
        ApisUrls.signIn,
        loginMessageHandler, (x) async {
      var info = User.fromJsonAfterLogin(x, emailController.text);
      await sharedPreferences.setString('token', info.token);
      await sharedPreferences.setBool('isLoggedIn', true);

      Navigator.pop(context, info);
    });
    await methods.hideProgressDialog();
  }

  void forgetPassword(BuildContext context) => waitForName(
          context,
          forgetPasswordFormKey,
          {'email': emailController.text},
          ApisUrls.resetPassword,
          forgetPasswordMessageHandler, (x) {
        toLoginPage(context);
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

  static String loginMessageHandler(BuildContext context) {
    return localization[16];
  }

  static String forgetPasswordMessageHandler(BuildContext context) {
    return localization[17];
  }

  static String registerMessageHandler(BuildContext context) {
    return localization[18];
  }

  Future<void> pickAvatar() async {
    avatarPath = await FilePicker.getFilePath(type: FileType.image);
    notifyListeners();
  }

  void removeSelectedAvatar() {
    avatarPath = null;
    notifyListeners();
  }

  static void showSnackBar(
    String message,
  ) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      // backgroundColor: color,
    ));
  }
}
