import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/screens/out_bnv/auth/logic.dart';
import 'package:provider/provider.dart';

class CreditCard {
  String regexp;
  String image;

  CreditCard(this.image, this.regexp);
}

class CheckOut extends StatelessWidget {
  static const route = '/checkout';
  final List<CreditCard> creditCards = [
    CreditCard('regexp', r"^3[47][0-9]{13}$"),
    CreditCard('regexp', r"^(6541|6556)[0-9]{12}$"),
    CreditCard('regexp', r"^3(?:0[0-5]|[68][0-9])[0-9]{11}$"),
    CreditCard('regexp',
        r"^65[4-9][0-9]{13}|64[4-9][0-9]{13}|6011[0-9]{12}|(622(?:12[6-9]|1[3-9][0-9]|[2-8][0-9][0-9]|9[01][0-9]|92[0-5])[0-9]{10})$"),
    CreditCard('regexp', r"^63[7-9][0-9]{13}$"),
    CreditCard('regexp', r"^(?:2131|1800|35\d{3})\d{11}$"),
    CreditCard('regexp', r"^9[0-9]{15}$"),
    CreditCard('regexp', r"^(6304|6706|6709|6771)[0-9]{12,15}$"),
    CreditCard('regexp', r"^(5018|5020|5038|6304|6759|6761|6763)[0-9]{8,15}$"),
    CreditCard('regexp',
        r"^(6334|6767)[0-9]{12}|(6334|6767)[0-9]{14}|(6334|6767)[0-9]{15}$"),
    CreditCard('regexp',
        r"^(4903|4905|4911|4936|6333|6759)[0-9]{12}|(4903|4905|4911|4936|6333|6759)[0-9]{14}|(4903|4905|4911|4936|6333|6759)[0-9]{15}|564182[0-9]{10}|564182[0-9]{12}|564182[0-9]{13}|633110[0-9]{10}|633110[0-9]{12}|633110[0-9]{13}$"),
    CreditCard('regexp', r"^(62[0-9]{14,17})$"),
    CreditCard('regexp', r"^4[0-9]{12}(?:[0-9]{3})?$"),
    CreditCard('regexp', r"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})$")
  ];
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of<Screen>(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    textEditingController.text = '4454545445454';
/*
options: Options(validateStatus: (x) {
      if (x == 200) {
        return true;
      } else {
        return true;
      }
    })
*/
    var rowPadding =
        Padding(padding: EdgeInsets.only(left: screen.widthConverter(10)));
    return SafeArea(
        child: Scaffold(
            //backgroundColor: Colors.white,
            body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverAppBar(
          snap: true,
          floating: true,
        )
      ],
      body: Form(
        // key: logic.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(20)),
          children: <Widget>[
            Text(
              'Check Out',
              style: textTheme.display2,
            ),
            HeadText(
              'Credit Card Details',
            ),
            MyTextField(
              'xxxx xxxx xxxx xxxx',
              controller: textEditingController,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              validator: (input) {
                for (var creditCard in creditCards) {
                  bool isValid = RegExp(creditCard.regexp).hasMatch(input);
                  print(isValid);

                  if (isValid) {
                    return null;
                  }
                }
                return 'Credit card not valid';
              },
            ),
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
                  child: MyTextField(
                    'Code',
                    controller: textEditingController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                  flex: 4,
                ),
                rowPadding,
                Expanded(
                  child: MyTextField(
                    'Phone Number',
                    controller: textEditingController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                  flex: 6,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screen.heightConverter(26.5),
                  bottom: screen.heightConverter(36)),
              child: FlatButton(
                child: Text('Pay Now'),
                onPressed: () {},
                color: theme.accentColor,
              ),
            ),
          ],
        ),
      ),
    )));
  }
}

class HeadText extends StatelessWidget {
  final String text;
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
  }
}
