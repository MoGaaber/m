import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/screens/bnv/pages/check_out/textField_helpers.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

/*
      'AL':	'Albania'
      'DZ':	'Algeria'
      'AS'	:'American' Samoa
      'AD':	'Andorra'
      'AO':	'Angola'
      'AI'	:'Anguilla'
      'AG'	:'Antigua and Barbuda'
      'AR'	:'Argentina'
      'AM':	'Armenia'
      'AW':	'Aruba'
      'AU':	'Australia'
      'AT':	'Austria'
      'AZ':	'Azerbaijan'
      'BS':'Bahamas'
      'BH':	'Bahrain'
      'BD':	'Bangladesh'
      'BB':	'Barbados'
      'BY':	'Belarus'
      'BE':	'Belgium'
      'BZ'	:'Belize'

 */
var x = [
  'AF',
  'AL',
  'DZ',
  'AS',
  'AD',
  'AO',
  'AI',
  'AG',
  'AR',
  'AM',
  'AW',
  'AU',
  'AT',
  'AZ',
  'BS',
  'BH',
  'BD',
  'BB',
  'BY',
  'BE',
  'BZ',
  'BJ',
  'BM',
  'BT',
  'BO',
  'BA',
  'BW',
  'BR',
  'IO',
  'VG',
  'BN',
  'BG',
  'BF',
  'BI',
  'KH',
  'CM',
  'CA',
  'CV',
  'KY',
  'CF',
  'TD',
  'CL',
  'CN',
  'CX',
  'CC',
  'CO',
  'KM',
  'CD',
  'CG',
  'CK',
  'CR',
  'CI',
  'HR',
  'CU',
  'CY',
  'CZ',
  'DK',
  'DJ',
  'DM',
  'DO',
  'EC',
  'EG',
  'SV',
  'GQ',
  'ER',
  'EE',
  'ET',
  'FK',
  'FO',
  'FJ',
  'FI',
  'FR',
  'GF',
  'PF',
  'GA',
  'GM',
  'GE',
  'DE',
  'GH',
  'GI',
  'GR',
  'GL',
  'GD',
  'GP',
  'GU',
  'GT',
  'GN',
  'GW',
  'GY',
  'HT',
  'HN',
  'HK',
  'HU',
  'IS',
  'IN',
  'ID',
  'IR',
  'IQ',
  'IE',
  'IT',
  'JM',
  'JP',
  'JO',
  'KZ',
  'KE',
  'KI',
  'KP',
  'KR',
  'KW',
  'KG',
  'LA',
  'LV',
  'LB',
  'LS',
  'LR',
  'LY',
  'LI',
  'LT',
  'LU',
  'MO',
  'MK',
  'MG',
  'MW',
  'MY',
  'MV',
  'ML',
  'MT',
  'MH',
  'MQ',
  'MR',
  'MU',
  'YT',
  'MX',
  'FM',
  'MD',
  'MC',
  'MN',
  'ME',
  'MS',
  'MA',
  'MZ',
  'MM',
  'NA',
  'NR',
  'NP',
  'NL',
  'AN',
  'NC',
  'NZ',
  'NI',
  'NE',
  'NG',
  'NU',
  'NF',
  'MP',
  'NO',
  'OM',
  'PK',
  'PW',
  'PS',
  'PA',
  'PG',
  'PY',
  'PE',
  'PH',
  'PN',
  'PL',
  'PT',
  'PR',
  'QA',
  'RE',
  'RO',
  'RU',
  'RW',
  'WS',
  'SM',
  'ST',
  'SA',
  'SN',
  'RS',
  'SC',
  'SL',
  'SG',
  'SK',
  'SI',
  'SB',
  'SO',
  'ZA',
  'ES',
  'LK',
  'SH',
  'KN',
  'LC',
  'PM',
  'VC',
  'SD',
  'SR',
  'SZ',
  'SE',
  'CH',
  'SY',
  'TJ',
  'TW',
  'TZ',
  'TH',
  'TL',
  'TG',
  'TK',
  'TO',
  'TT',
  'TN',
  'TR',
  'TM',
  'TC',
  'TV',
  'UG',
  'UA',
  'AE',
  'GB',
  'VI',
  'US',
  'UY',
  'UZ',
  'VU',
  'VA',
  'VE',
  'VN',
  'WF',
  'EH',
  'YE',
  'ZM',
  'ZW',
];

class CountriesLogic extends ChangeNotifier {
  List<dynamic> countries;

  CountriesLogic(BuildContext context) {
    countries = Localization.of(context).countries;
    countries = countries.map((e) => {'selected': false, 'name': e}).toList();
  }
  int oldIndex;

  void onTapCountry(int index) {
    countries[index]['selected'] = true;
    if (oldIndex != null) countries[oldIndex]['selected'] = false;
    oldIndex = index;
    notifyListeners();
  }
}

class CountriesRoot extends StatelessWidget {
  static const route = 'countries';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountriesLogic(context),
      child: Countries(),
    );
  }
}

class Countries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isoCodes = [];
    CountriesLogic logic = Provider.of(context);
    var search = Localization.of(context).search;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: <Widget>[
            MyTextField(search[0]),
            Expanded(
              child: ListView.builder(
                  itemCount: logic.countries.length,
                  itemBuilder: (_, int index) {
                    return ListTile(
                      onTap: () => logic.onTapCountry(index),
                      title: Text(logic.countries[index]['name']),
                      trailing: Icon(
                        Icons.check,
                        color: logic.countries[index]['selected']
                            ? Colors.green
                            : Colors.grey,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckOutRoot extends StatelessWidget {
  static const route = '/checkout';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => CheckOutLogic(), child: CheckOut());
  }
}

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of<Screen>(context);
    var localization = Localization.of(context).checkOut;
    var logic = Provider.of<CheckOutLogic>(context);
    String price = ModalRoute.of(context).settings.arguments;
    logic.price = price;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return SafeArea(
        child: Scaffold(
            key: logic.scaffoldKey,
            floatingActionButton: FloatingActionButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ListView(
                      children: <Widget>[],
                    );
                  });
            }),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  snap: true,
                  floating: true,
                )
              ],
              body: Form(
                key: TextFieldHelpers.key,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: screen.widthConverter(20)),
                  children: <Widget>[
                    Text(
                      localization[0],
                      style: textTheme.display2,
                    ),
                    HeadText(
                      localization[1],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MyTextField(
                            localization[2],
                            controller: TextFieldHelpers.firstNameController,
                          ),
                          flex: 10,
                        ),
                        Spacer(),
                        Expanded(
                          child: MyTextField(
                            localization[3],
                            controller: TextFieldHelpers.surNameController,
                          ),
                          flex: 10,
                        ),
                      ],
                    ),
                    HeadText(localization[4]),
                    MyTextField(
                      localization[5],
                      controller: TextFieldHelpers.addressController,
                    ),
                    MyTextField(
                      localization[6],
                      controller: TextFieldHelpers.cityController,
                    ),
                    MyTextField(
                      localization[12],
                      controller: TextFieldHelpers.regionController,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MyTextField(
                            localization[7],
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            controller: TextFieldHelpers.postalCodeController,
                          ),
                          flex: 10,
                        ),
                        Spacer(),
                        Expanded(
                          child: MyTextField(
                            localization[8],
                            controller: TextFieldHelpers.cityController,
                            trailling: GestureDetector(
                                child: Icon(
                              Icons.keyboard_arrow_down,
                            )),
                          ),
                          flex: 10,
                        )
                      ],
                    ),
                    HeadText(
                      localization[9],
                    ),
                    MyTextField(
                      localization[10],
                      controller: TextFieldHelpers.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screen.heightConverter(26.5),
                          bottom: screen.heightConverter(36)),
                      child: FlatButton(
                        child: Text(localization[11]),
                        onPressed: () => logic.pay(context),
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
/*
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: MyTextField(
//                    'Code',
//                    controller: textEditingController,
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ],
//                  ),
//                  flex: 4,
//                ),
//                rowPadding,
//                Expanded(
//                  child: MyTextField(
//                    'Phone Number',
//                    controller: textEditingController,
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly
//                    ],
//                  ),
//                  flex: 6,
//                )
//              ],
//            ),
//            MyTextField(
//              'xxxx xxxx xxxx xxxx',
//              controller: textEditingController,
//              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//              keyboardType: TextInputType.number,
//              validator: (input) {
//                return 'Credit card not valid';
//              },
//            ),
//            MyTextField(
//              'Select Card Type',
//              trailling:
//                  GestureDetector(child: Icon(Icons.keyboard_arrow_down)),
//            ),

class CreditCard {
  String regexp;
  String image;

  CreditCard(this.image, this.regexp);
}

for (var creditCard in creditCards) {
bool isValid = RegExp(creditCard.regexp).hasMatch(input);
print(isValid);

if (isValid) {
return null;
}
}

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
 */
