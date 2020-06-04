import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/methods.dart';
import 'package:m/main.dart';
import 'package:m/screens/bnv/pages/check_out/textField_helpers.dart';
import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart';

class CheckOutLogic extends ChangeNotifier {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String price;
  Future<void> pay(BuildContext context) async {
    if (TextFieldHelpers.key.currentState.validate()) {
      await Methods(context).showProgressDialog();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      var androidInfo = await deviceInfo.androidInfo;
      var deviceType = '${androidInfo.brand} ${androidInfo.model}';
      var deviceId = androidInfo.androidId;
      var userId = sharedPreferences.getString('token') ?? 'not logged in yet';
      sharedPreferences.getBool('isLoggedIn');
      var cartId = Uuid().v1();
      print(deviceId);
      print(deviceType);
      print(userId);
      print(price);
      print(TextFieldHelpers.regionController.text);
      print(TextFieldHelpers.cityController.text);
      print(TextFieldHelpers.countryController.text);
      print(TextFieldHelpers.postalCodeController.text);
      print(TextFieldHelpers.emailController.text);
      print(TextFieldHelpers.addressController.text);
      print(TextFieldHelpers.surNameController.text);
      print(TextFieldHelpers.firstNameController.text);

      var stringXmlRequest = '''<?xml version="1.0" encoding="UTF-8"?>
<mobile>
  <store>23065</store>
  <key>QTtww-nKJG#MvXqC</key> 
  <device>
    <type>$deviceType</type>
    <id>$deviceId</id>

  </device>
  <app>
    <name>Touri</name>
    <version>1.0.0</version>
    <user>$userId</user>
    <id>why</id>
  </app>
  <tran>
    <test>1</test>
    <type>paypage</type>
    <class>ecom</class>
    <cartid>$cartId</cartid>
    <description>uuuuuu</description>
    <currency>sar</currency>
    <amount>$price</amount>
  </tran>
  <billing>
    <name>
      <first>${TextFieldHelpers.firstNameController.text}</first>
      <last>${TextFieldHelpers.surNameController.text}</last>
    </name>
    <address>
      <line1>${TextFieldHelpers.addressController.text}</line1>
      <city>${TextFieldHelpers.cityController.text}</city>
      <region>${TextFieldHelpers.regionController.text}</region>
      <country>EG</country>
      <zip>${TextFieldHelpers.postalCodeController.text}</zip>
    </address>
    <email>${TextFieldHelpers.emailController.text}</email>
  </billing>
</mobile>

''';
      var response = await Dio()
          .post('https://secure.innovatepayments.com/gateway/mobile.xml',
              options: Options(
                contentType: 'application/xml',
                headers: {'Content-Type': 'application/xml'},
              ),
              data: stringXmlRequest);
      var xmlResponse = XmlDocument.parse(response.data);
      print(xmlResponse);
      var url = (xmlResponse
          .getElement('mobile')
          .getElement('webview')
          .getElement('start')
          .text);
      Methods(context).hideProgressDialog();
      Navigator.pushNamed(
        context,
        MyWebView.route,
        arguments: url,
      );
    } else {
      Methods.showSnackBar(scaffoldKey, Localization.of(context).checkOut[12]);
    }
  }
}
