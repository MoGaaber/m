class Constants {
  static const englishLetters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  static String checkLanguage(String letter) {
    for (var item in englishLetters) {
      if (letter.toLowerCase() == item.toLowerCase()) {
        return 'en';
      }
    }
    return 'ar';
  }
}
