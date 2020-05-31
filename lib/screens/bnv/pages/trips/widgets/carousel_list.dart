import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m/COMMONS/widgets/title_and_show_more.dart';
import 'package:m/commons/models/image_and_text._model.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/image_with_text.dart';
import 'package:m/screens/bnv/pages/trips/models/slider_list.dart';
import 'package:provider/provider.dart';

import '../../../../../COMMONS/widgets/slider.dart';
import '../logic.dart';

var lorem =
    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which dont look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isnt anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc';

class CarouselList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<TripsLogic>(context, listen: true);
    var themeData = Theme.of(context);
    var textTheme = themeData.textTheme;
    Screen screen = Provider.of(context);
    return MyFutureBuilder<Response<Map<String, dynamic>>>(
      request: logic.getSlider,
      empty: Text('networdl'),
      serverError: Text('networdl'),
      networkError: Text('networdl'),
      fullResponse: (snapshot) {
        SliderModel sliderModel = SliderModel(context, snapshot.data);
        return Stack(
          children: <Widget>[
            CarouselSlider.builder(
              options: CarouselOptions(
                  onPageChanged: logic.onSliderPageChanged,
                  height: screen.heightConverter(220),
                  viewportFraction: 1.0,
                  scrollPhysics: BouncingScrollPhysics(),
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  // autoPlayCurve: Curves.elasticInOut,
                  autoPlayInterval: Duration(seconds: 5)),
              itemCount: sliderModel.castedResponse.length,
              itemBuilder: (BuildContext context, int i) => Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screen.widthConverter(5)),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screen.aspectRatioConverter(10))),
                      child: ExtendedImage.network(
                        sliderModel.castedResponse[i].mainImage + '',
                        // 'https://i.pinimg.com/originals/7c/cb/01/7ccb010d8fddc4bcd84587ef3c34d100.jpg',
                        fit: BoxFit.cover,
                        loadStateChanged: (ExtendedImageState state) {
                          print(state.loadingProgress);
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return Material(
                                child: Center(
                                    child: SizedBox(
                                        child: CircularProgressIndicator(),
                                        height: screen.heightConverter(25),
                                        width: screen.widthConverter(25))),
                              );

                              break;

                            case LoadState.failed:
                              return Material(
                                // color: Color(0xfff3f3f4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Spacer(
                                      flex: 3,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.image,
                                      // color: Colors.white,
                                      size: screen.heightConverter(80),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Center(child: Text('Failed load image')),
                                    Spacer(
                                      flex: 2,
                                    ),
                                    ButtonTheme(
                                      textTheme: ButtonTextTheme.primary,
                                      minWidth: screen.widthConverter(200),
                                      height: screen.heightConverter(40),
                                      child: Center(
                                        child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(screen
                                                        .aspectRatioConverter(
                                                            10)))),
                                            color: themeData.accentColor,
                                            onPressed: state.reLoadImage,
                                            child: Text(
                                              'reload',
                                              style: textTheme.caption,
                                            )),
                                      ),
                                    ),
                                    Spacer(
                                      flex: 6,
                                    ),
                                  ],
                                ),
                              );
                              ;
                              break;
                            default:
                              {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    ExtendedRawImage(
                                      image: state.extendedImageInfo?.image,
                                      fit: BoxFit.cover,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screen.widthConverter(10)),
                                          child: AutoSizeText(
                                            sliderModel.castedResponse[i].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 10,

                                            // minFontSize: ScreenUtil()
                                            //     .setSp(15)
                                            //     .roundToDouble(),
                                            style: textTheme.display2.copyWith(
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: screen
                                                          .aspectRatioConverter(
                                                              4)),
                                                ]),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }
                              break;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sliderModel.castedResponse.map((url) {
                  int index = sliderModel.castedResponse.indexOf(url);
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screen.widthConverter(5)),
                    child: AnimatedContainer(
                      curve: Curves.easeInOutQuad,
                      width: screen.widthConverter(
                          logic.currentSliderIndex == index ? 15 : 10),
                      height: screen.heightConverter(
                          logic.currentSliderIndex == index ? 15 : 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: screen.aspectRatioConverter(0.5))
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
        // return MyCarouselSlider(
        //   data: sliderModel.castedResponse,
        //   item: carouselViewItem,
        // );
      },
      loading: ShimmerCarouselSlider(),
    );
  }
}

class ShimmerCarouselSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var themeData = Theme.of(context);

    return CarouselSlider.builder(
        options: CarouselOptions(
          viewportFraction: 1.0,
          autoPlay: false,
          scrollPhysics: BouncingScrollPhysics(),
          height: screen.heightConverter(220),
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) => Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screen.widthConverter(5)),
              child: myShimmer(context: context),
            ));
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
