import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m/COMMONS/widgets/title_and_show_more.dart';
import 'package:m/commons/models/image_and_text._model.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/image_with_text.dart';
import 'package:m/screens/bnv/pages/trips/models/slider_list.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class CarouselList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<TripsLogic>(context, listen: false);
    return MyFutureBuilder<Response<Map<String, dynamic>>>(
      request: logic.getSlider,
      empty: Text('networdl'),
      serverError: Text('networdl'),
      networkError: Text('networdl'),
      fullResponse: (snapshot) {
        SliderModel sliderModel = SliderModel(context, snapshot.data);
        return MyCarouselSlider(
          data: sliderModel.castedResponse,
          item: carouselViewItem,
        );
      },
      loading: MyCarouselSlider(
        item: myShimmer,
      ),
    );
  }
}

class MyCarouselSlider extends StatelessWidget {
  final List<ImageAndTextModel> data;
  final Item item;

  MyCarouselSlider({this.data, this.item});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var themeData = Theme.of(context);

    return CarouselSlider.builder(
        options: CarouselOptions(
          autoPlayInterval: Duration(seconds: 3),
          autoPlay: false,
          viewportFraction: 0.9,
          scrollPhysics: BouncingScrollPhysics(),
          height: (screen.heightConverter(200)),
        ),
        itemCount: data?.length ?? 5,
        itemBuilder: (BuildContext context, int index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(2)),
            child: item(context: context, data: data, index: index)));
  }
}

Widget carouselViewItem(
    {BuildContext context, List<dynamic> data, int index, void cast}) {
  Screen screen = Provider.of(context);
  var themeData = Theme.of(context);
  var textTheme = themeData.textTheme;

  return ImageWithItsText(
    alignmentGeometry: Alignment.center,
    imageUrl: data[index].mainImage,
    text: Padding(
      padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(10)),
      child: AutoSizeText(data[index].title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: textTheme.display2.copyWith(color: Colors.white)),
    ),
  );
}
