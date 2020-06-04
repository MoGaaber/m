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
      'search': ['Search', 'Empty search query .. start type one'],
      'profile': ['Profile', 'Language', 'Log out'],
      'auth': [
        'Login',
        'Sign up',
        'Create new account',
        'Forget password',
        'First name',
        'Last name',
        'Email',
        'Password',
        'Repeat password',
        'This Field is required',
        'Invalid email Address',
        'Password must be equal or greater than 8 letters',
        'Password not identical',
        'Reset your password',
        'Problem in our server we art working on fix it',
        'Problem in your network connection .. please check it',
        'Recheck your Email and password',
        'Recheck your Email',
        'Email address is Already Taken'
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
      'book': [
        'Book This Tour',
        'Tour',
        'Date',
        'Passengers',
        'Booking',
        'Passenger',
        'Done',
        'Cancel',
        'Clear',
        'Adults',
        'Children',
        'Infants',
        'under',
        'year',
        'Must select date and passengers',
        'Something went wrong try again',
        'Booking is successfully done',
        'Select Date'
      ],
      'info': ['Booking'],
      'checkOut': [
        'Check Out',
        'Credit Card Details',
        'First Name',
        'Sur Name',
        'Billing Information',
        'Street Address',
        'City',
        'Post Code',
        'Country',
        'Contact Details',
        'Email',
        'Pay Now',
        'Region',
        'You should fill all Fields'
      ],
      'globals': ['Wait for loading ..'],
      'more': ['More', 'Less', 'View on map'],
    },
    'ar': {
      'language': ['اللغة'],
      'info': ['إحجز'],
      'search': ['البحث', 'كلمة البحث فارغة .. إبدا فى كتابة واحدة الآن'],
      'profile': ['الملف الشخصي', 'اللغه', 'تسجيل الخروج'],
      'auth': [
        'تسجيل الدخول',
        'التسجيل كمستخدم جديد',
        'عمل حساب جديد',
        'نسيت كلمة المرور',
        'الإسم الأول',
        'الإسم الاخير',
        'البريد الإلكتروني',
        'كلمة المرور',
        'أعد كتابة كلمة المرور',
        'هذا الحقل مطلوب',
        'البريد الإلكتروني غير صحيح',
        'كلمه المرور يجب ان تكون 8 حروف على الأقل',
        'كلمة المرور غير متطابقة',
        'أعد تعيين كلمة المرور',
        'هناك مشكلة فى سيرفرنا نحن نعمل الآن على حلها',
        'هناك مشكلة في إتصالك بالإنترنت',
        'تأكد من البريد الإلكترونى وكلمة المرور',
        'تأكد من بريدك الإلكتروني',
        'هذا البريد مستخدم من قبل مستخدم آخر'
      ],
      'checkOut': [
        'الدفع',
        'تفاصيل بطاقة الإئتمان',
        'الإسم الأول',
        'اللقب',
        'معلومات الفواتير',
        'عنوان الشارع',
        'المدينة',
        'الرقم البريدي',
        'الدولة',
        'بيانات الإتصال',
        'البريد الإلكترونى',
        'إدفع الآن',
        'المنطقة',
        'يجب عليك ملأ كل الحقول'
      ],
      'book': [
        'إحجز هذه الرحلة',
        'الرحلة',
        'التاريخ',
        'الركاب',
        'الحجز',
        'راكب',
        'تم',
        'الغاء',
        'مسح',
        'بالغين',
        'اطفال',
        'رضع',
        'عام',
        'يجب إدخال التاريخ وعدد الركاب',
        'هناك مشكلة حدثت حاول مرة اخري',
        'تم الحجز بنجاح',
        'حدد التاريخ'
      ],
      'globals': ['.. إنتظر جاري التحميل'],
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
  List<String> get globals => langugeCode['globals'];
  List<String> get book => langugeCode['book'];
  List<String> get checkOut => langugeCode['checkOut'];

  List<String> get auth => langugeCode['auth'];

  List<String> get search => langugeCode['search'];
  List<String> get profile => langugeCode['profile'];
  List<String> get filter => langugeCode['filter'];
  List<String> get info => langugeCode['info'];
}
