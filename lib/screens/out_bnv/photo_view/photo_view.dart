import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/out_bnv/photo_view/model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class MyPhotoView extends StatelessWidget {
  static const route = '/photo_view';
  @override
  Widget build(BuildContext context) {
    PhotoViewArguments photoViewArguments =
        ModalRoute.of(context).settings.arguments;
    final screen = (Provider.of<Screen>(context));

    return Container(
        child: PhotoViewGallery.builder(
      pageController:
          PageController(initialPage: photoViewArguments.currentImageIndex),
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(photoViewArguments.images[index]),
          initialScale: PhotoViewComputedScale.contained * 0.8,
        );
      },
      itemCount: photoViewArguments.images.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: screen.widthConverter(20),
          height: screen.heightConverter(20),
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
    ));
  }
}
