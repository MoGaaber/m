import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
class Countries extends StatelessWidget {
  static const route = 'countries';
  @override
  Widget build(BuildContext context) {
    var counries = [
      'Afghanistan',
      'Albania',
      'Algeria',
      'American Samoa',
      'Andorra',
      'Angola',
      'Anguilla',
      'Antigua and Barbuda',
      'Argentina',
      'Armenia',
      'Aruba',
      'Australia',
      'Austria',
      'Azerbaijan',
      'Bahamas',
      'Bahrain',
      'Bangladesh',
      'Barbados',
      'Belarus',
      'Belgium',
      'Belize',
      'Benin',
      'Bermuda',
      'Bhutan',
      'Bolivia',
      'Bosnia and Herzegovina',
      'Botswana',
      'Brazil',
      'British Indian Ocean Territory',
      'British Virgin Islands',
      'Brunei Darussalam',
      'Bulgaria',
      'Burkina Faso',
      'Burundi',
      'Cambodia',
      'Cameroon',
      'Canada',
      'Cape Verde',
      'Cayman Islands',
      'Central African Rep',
      'Chad',
      'Chile',
      'China',
      'Christmas Island',
      'Cocos (Keeling) Islands',
      'Colombia',
      'Comoros',
      'Congo, Democratic Rep of',
      'Congo, Republic of',
      'Cook Islands',
      'Costa Rica',
      "Cote d'Ivoire",
      'Croatia',
      'Cuba',
      'Cyprus',
      'Czech Rep',
      'Denmark',
      'Djibouti',
      'Dominica',
      'Dominican Rep',
      'Ecuador',
      'Egypt',
      'El Salvador',
      'Equatorial Guinea',
      'Eritrea',
      'Estonia',
      'Ethiopia',
      'Falkland Islands',
      'Faroe Islands',
      'Fiji',
      'Finland',
      'France',
      'French Guyana',
      'French Polynesia',
      'Gabon',
      'Gambia',
      'Georgia',
      'Germany',
      'Ghana',
      'Gibraltar',
      'Greece',
      'Greenland',
      'Grenada',
      'Guadeloupe',
      'Guam',
      'Guatemala',
      'Guinea',
      'Guinea-Bissau',
      'Guyana',
      'Haiti',
      'Honduras',
      'Hong Kong',
      'Hungary',
      'Iceland',
      'India',
      'Indonesia',
      'Iran',
      'Iraq',
      'Ireland',
      'Italy',
      'Jamaica',
      'Japan',
      'Jordan',
      'Kazakhstan',
      'Kenya',
      'Kiribati',
      'Korea, North',
      'Korea, South',
      'Kuwait',
      'Kyrgyzstan',
      'Laos',
      'Latvia',
      'Lebanon',
      'Lesotho',
      'Liberia',
      'Libya',
      'Liechtenstein',
      'Lithuania',
      'Luxembourg',
      'Macau',
      'Macedonia',
      'Madagascar',
      'Malawi',
      'Malaysia',
      'Maldives',
      'Mali',
      'Malta',
      'Marshall Islands',
      'Martinique',
      'Mauritania',
      'Mauritius',
      'Mayotte',
      'Mexico',
      'Micronesia',
      'Moldova, Rep of',
      'Monaco',
      'Mongolia',
      'Montenegro',
      'Montserrat',
      'Morocco',
      'Mozambique',
      'Myanmar',
      'Namibia',
      'Nauru',
      'Nepal',
      'Netherlands',
      'Netherlands Antilles',
      'New Caledonia',
      'New Zealand',
      'Nicaragua',
      'Niger',
      'Nigeria',
      'Niue',
      'Norfolk Island',
      'Northern Mariana Islands',
      'Norway',
      'Oman',
      'Pakistan',
      'Palau',
      'Palestinian Territory, Occupied',
      'Panama',
      'Papua New Guinea',
      'Paraguay',
      'Peru',
      'Philippines',
      'Pitcairn Islands',
      'Poland',
      'Portugal',
      'Puerto Rico',
      'Qatar',
      'Reunion',
      'Romania',
      'Russian Federation',
      'Rwanda',
      'Samoa',
      'San Marino',
      'Sao Tome and Principe',
      'Saudi Arabia',
      'Senegal',
      'Serbia',
      'Seychelles',
      'Sierra Leone',
      'Singapore',
      'Slovakia',
      'Slovenia',
      'Solomon Islands',
      'Somalia',
      'South Africa',
      'Spain',
      'Sri Lanka',
      'St Helena',
      'St Kitts and Nevis',
      'St Lucia',
      'St Pierre and Miquelon',
      'St Vincent and Grenadines',
      'Sudan',
      'Suriname',
      'Swaziland',
      'Sweden',
      'Switzerland',
      'Syria',
      'Taiwan, Rep of China',
      'Tajikistan',
      'Tanzania',
      'Thailand',
      'Timor-Leste',
      'Togo',
      'Tokelau',
      'Tonga',
      'Trinidad and Tobago',
      'Tunisia',
      'Turkey',
      'Turkmenistan',
      'Turks and Caicos Islands',
      'Tuvalu',
      'Uganda',
      'Ukraine',
      'United Arab Emirates',
      'United Kingdom',
      'United States of America',
      'United States Virgin Islands',
      'Uruguay',
      'Uzbekistan',
      'Vanuatu',
      'Vatican City',
      'Venezuela',
      'Viet Nam',
      'Wallis and Futuna Islands',
      'Western Sahara',
      'Yemen',
      'Zambia',
      'Zimbabwe'
    ];
    var countries2 = [
      'أفغانستان',
      'ألبانيا',
      'الجزائر',
      'ساموا الأمريكية',
      'أندورا',
      'أنغولا',
      'أنغيلا',
      'أنتيغوا وبربودا',
      'الأرجنتين',
      'أرمينيا',
      'أروبا',
      'أستراليا',
      'النمسا',
      'أذربيجان',
      'جزر البهاما',
      'البحرين',
      'بنغلاديش',
      'بربادوس',
      'روسيا البيضاء',
      'بلجيكا',
      'بليز',
      'بنين',
      'برمودا',
      'بوتان',
      'بوليفيا',
      'البوسنة والهرسك',
      'بوتسوانا',
      'البرازيل',
      'إقليم المحيط البريطاني الهندي',
      'جزر فيرجن البريطانية',
      'بروناي دار السلام',
      'بلغاريا',
      'بوركينا فاسو',
      'بوروندي',
      'كمبوديا',
      'الكاميرون',
      'كندا',
      'الرأس الأخضر',
      'جزر كايمان',
      'جمهورية إفريقيا الوسطى',
      'تشاد',
      'تشيلي',
      'الصين',
      'جزيرة الكريسماس',
      'جزر كوكوس (كيلنج)',
      'كولومبيا',
      'جزر القمر',
      'جمهورية الكونغو الديمقراطية',
      'جمهورية الكونغو',
      'جزر كوك',
      'كوستا ريكا',
      'ساحل العاج',
      'كرواتيا',
      'كوبا',
      'قبرص',
      'جمهورية التشيك',
      'الدنمارك',
      'جيبوتي',
      'دومينيكا',
      'جمهورية الدومينيكان',
      'إكوادور',
      'مصر',
      'السلفادور',
      'غينيا الإستوائية',
      'إريتريا',
      'إستونيا',
      'أثيوبيا',
      'جزر فوكلاند',
      'جزر فاروس',
      'فيجي',
      'فنلندا',
      'فرنسا',
      'غيانا الفرنسية',
      'بولينيزيا الفرنسية',
      'الغابون',
      'غامبيا',
      'جورجيا',
      'ألمانيا',
      'غانا',
      'جبل طارق',
      'اليونان',
      'الأرض الخضراء',
      'غرينادا',
      '	غواديلوب',
      'غوام',
      'غواتيمالا',
      'غينيا',
      '	غينيا - بيساو',
      'غيانا',
      'هايتي',
      'هندوراس',
      'هونج كونج',
      'هنغاريا',
      'أيسلندا',
      'الهند',
      'إندونيسيا',
      'إيران',
      'العراق',
      'أيرلندا',
      'إيطاليا'
    ];
    var isoCodes = [];
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, int index) {
            return ListTile(
              title: Text('Hello'),
            );
          }),
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
