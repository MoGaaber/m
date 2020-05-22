import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  final Function(int index) onTap;
  final List imagseUrl;
  final String title;
  MySlider(this.title, this.imagseUrl, {this.onTap});
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textTheme = themeData.textTheme;

    return FlexibleSpaceBar(
        background: GestureDetector(
      onTap: () {},
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Carousel(
            onImageTap: this.onTap,
            images: [
              for (var imageUrl in imagseUrl)
                Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ],
                )
            ],
            boxFit: BoxFit.cover,
            overlayShadow: false,
            showIndicator: true,
            autoplay: false,
            dotSize: 6,
          ),
          IgnorePointer(
            child: Column(
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Text(
                  this.title,
                  style: textTheme.display2.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
