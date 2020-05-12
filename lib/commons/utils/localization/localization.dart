import 'package:flutter/material.dart';

class Localization {
  Localization(this.locale);

  final Locale locale;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  static Map<String, Map> _localizedValues = {
    'en': {
      'language': ['Language'],
      'search': 'Search',
      'profile': ['Profile', 'Language', 'Log out'],
      'auth': [
        'Login',
        'Sign up',
        'Forget password',
        'First name',
        'Last name',
        'Email',
        'Password',
        'This Field is required',
        'Invalid email Address',
        'Password must be equal or greater than 8 letters',
        'Password not identical'
      ],
      'filter': [
        'Filters',
        'Cities',
        'Features',
        'Price',
        'Price Range',
        'Filters',
        'Clear Filter'
      ],
      'more': ['More', 'Less', 'View on map']
    },
    'ar': {
      'language': ['اللغة'],
      'search': 'البحث',
      'profile': ['الملف الشخصي', 'اللغه', 'تسجيل الخروج'],
      'filter': [
        'التصفيات',
        'المدينة',
        'الميزة',
        'السعر',
        'مجال السعر',
        'التصفية',
        'إزالة التصفية'
      ]
    }
  };

  get langugeCode {
    return _localizedValues[locale.languageCode];
  }

  List<String> get language => langugeCode['language'];

  String get search => langugeCode['search'];
  List<String> get profile => langugeCode['profile'];
  List<String> get filter => langugeCode['filter'];
}
