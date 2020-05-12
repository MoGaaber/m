import 'package:flutter/material.dart';

class ImageWithItsText extends StatelessWidget {
  final String imageUrl;
  final Widget text;
  final VoidCallback onTap;
  final AlignmentGeometry alignmentGeometry;
  final double opacity;
  final bool haveRadius;
  ImageWithItsText(
      {this.text,
      this.onTap,
      this.opacity = 0.0,
      this.alignmentGeometry = Alignment.center,
      this.imageUrl,
      this.haveRadius = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(haveRadius ? 12 : 0)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(this.opacity),
            ),
            Align(alignment: alignmentGeometry, child: text),
          ],
        ),
      ),
    );
  }
}
