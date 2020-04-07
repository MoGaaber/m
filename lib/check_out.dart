import 'package:flutter/material.dart';
import 'package:m/forget.dart';
import 'package:m/info.dart';
import 'package:m/logic.dart';
import 'package:m/main.dart';
import 'package:m/screen.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  static const route = '/checkout';
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of<Screen>(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var rowPadding =
        Padding(padding: EdgeInsets.only(left: screen.widthConverter(10)));
    return UserRegistirationRoot(
        'Check Out',
        Column(
          children: <Widget>[
            HeadText(
              'Credit Card Details',
            ),
            MyTextField('xxxx xxxx xxxx xxxx'),
            MyTextField(
              'Select Card Type',
              trailling:
                  GestureDetector(child: Icon(Icons.keyboard_arrow_down)),
            ),
            MyTextField('Name on card'),
            HeadText('Billing Information'),
            MyTextField('Street address'),
            MyTextField('City'),
            Row(
              children: <Widget>[
                Expanded(
                  child: MyTextField('Post Code'),
                  flex: 4,
                ),
                rowPadding,
                Expanded(
                  child: MyTextField(
                    'Country',
                    trailling:
                        GestureDetector(child: Icon(Icons.keyboard_arrow_down)),
                  ),
                  flex: 6,
                )
              ],
            ),
            HeadText(
              'Contact Details',
            ),
            MyTextField('Email'),
            Row(
              children: <Widget>[
                Expanded(
                  child: MyTextField('Code'),
                  flex: 4,
                ),
                rowPadding,
                Expanded(
                  child: MyTextField('Phone Number'),
                  flex: 6,
                )
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        'Pay Now',
        () {});
  }
}

class HeadText extends StatelessWidget {
  String text;
  HeadText(this.text);

  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.only(
          top: screen.heightConverter(26), bottom: screen.heightConverter(14)),
      child: Text(
        this.text,
        style: textTheme.body2,
      ),
    );
    ;
  }
}
