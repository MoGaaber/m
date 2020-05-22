import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/packages/extended_image/extended_image.dart';
import 'package:m/packages/src/extended_image.dart';
import 'package:m/packages/src/extended_image_utils.dart';
import 'package:provider/provider.dart';

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
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MyNetworkImage(this.imageUrl),
          Align(alignment: alignmentGeometry, child: text),
        ],
      ),
    );
  }
}

class MyNetworkImage extends StatelessWidget {
  final String imageUrl;
  MyNetworkImage(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    return ExtendedImage.network(
      imageUrl,
      // 'https://i.pinimg.com/originals/7c/cb/01/7ccb010d8fddc4bcd84587ef3c34d100.jpg',
      fit: BoxFit.cover,
      loadStateChanged: (ExtendedImageState state) {
        var loadState = state.extendedImageLoadState;
        if (loadState == LoadState.loading) {
          return Material(
            child: Center(
                child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: screen.heightConverter(15),
                    width: screen.widthConverter(15))),
          );
        } else if (loadState == LoadState.failed) {
          return Material(
            child: InkWell(
              onTap: state.reLoadImage,
              child: Center(
                child: Icon(Icons.refresh),
              ),
            ),
          );
        } else {}
      },
    );
    return ClipRRect(
      borderRadius:
          BorderRadius.all(Radius.circular(screen.aspectRatioConverter(10))),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (_, __, error) {
          return IconButton(
            icon: Icon(Icons.error),
            onPressed: () {},
          );
        },
      ),
    );
  }
}
