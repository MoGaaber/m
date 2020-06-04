import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';

class MyRatingBar extends StatelessWidget {
  double itemSize;
  MyRatingBar(this.itemSize);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemSize: this.itemSize,
      itemCount: 5,
      rating: 4,
      unratedColor: Colors.grey,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Color(0xffFDC60A),
      ),
    );
  }
}
