import 'package:flutter/material.dart';

class Screen {
  MediaQueryData mediaQueryData;
  Size size;
  double myHeight = 667;
  double myWidth = 375;
  double get height => size.height;
  double get width => size.width;
  double get myAspectRatio => myWidth / myHeight;
  double get aspectRatio => size.aspectRatio;
  double get textScale => mediaQueryData.textScaleFactor;

  double convert(double input, double from) {
    return (input * from) / from;
  }

  double heightConverter(double x) {
    return (x * height) / myHeight;
  }

  double widthConverter(double x) {
    return (x * width) / myWidth;
  }

  double aspectRatioConverter(double x) {
    return (x * aspectRatio) / myAspectRatio;
  }
}
