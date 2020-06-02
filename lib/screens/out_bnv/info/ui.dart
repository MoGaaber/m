import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/image_with_text.dart';
import 'package:m/commons/widgets/map.dart';
import 'package:m/commons/widgets/slider.dart';
import 'package:m/screens/out_bnv/book_flight/ui.dart';
import 'package:m/screens/out_bnv/info/logic.dart';
import 'package:provider/provider.dart';

import '../photo_view/model.dart';
import '../photo_view/photo_view.dart';

class InfoRoot extends StatelessWidget {
  static const route = '/info';
  GoogleMapController googleMapController;
  @override
  build(BuildContext context) {
    return ChangeNotifierProvider(
      child: Info(),
      create: (BuildContext context) => InfoLogic(),
    );
  }
}

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = (Provider.of<Screen>(context));
    final theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var logic = Provider.of<InfoLogic>(context);
    logic.horizontalListElement = ModalRoute.of(context).settings.arguments;
    var horizontalListElement = logic.horizontalListElement;
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.white,
            expandedHeight: screen.heightConverter(200),
            flexibleSpace: !horizontalListElement.isOtherImagesEmpty
                ? MySlider(
                    horizontalListElement.getTitle,
                    horizontalListElement.getAllImages,
                    onTap: (index) {
                      Navigator.of(context).pushNamed(MyPhotoView.route,
                          arguments: PhotoViewArguments(
                              horizontalListElement.getAllImages, index));
                    },
                  )
                : ImageWithItsText(
                    haveRadius: false,
                    imageUrl: horizontalListElement.mainImagePath,
                    text: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(
                          flex: 2,
                        ),
                        Text(
                          horizontalListElement.getTitle,
                          style:
                              textTheme.display2.copyWith(color: Colors.white),
                        ),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(
                      top: screen.heightConverter(20),
                      left: screen.widthConverter(18.5),
                      right: screen.widthConverter(18.5),
                      bottom: screen.widthConverter(0)),
                  child: Consumer<InfoLogic>(
                    builder: (BuildContext context, InfoLogic infoLogic,
                            Widget child) =>
                        Text(
                      horizontalListElement.getOverView,
                      //     infoLogic.infoModel.isOverViewLong
                      // ? '  ....'
                      // : '',
                      style: textTheme.body1,
                    ),
                  ),
                ),
                horizontalListElement.isOverViewLong
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            child: GestureDetector(
                              onTap: () {
                                logic.toggleMorLess();
                              },
                              child: Consumer<InfoLogic>(
                                builder: (BuildContext context,
                                        InfoLogic infoLogic, Widget child) =>
                                    Text(
                                  horizontalListElement.toggleMoreLess
                                      ? 'more'
                                      : 'less',
                                  style: textTheme.body1.copyWith(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.only(
                                right: screen.widthConverter(18.5),
                                top: screen.heightConverter(15),
                                bottom: screen.heightConverter(30))),
                      )
                    : SizedBox.shrink(),
                horizontalListElement.latLng == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screen.heightConverter(40),
                            horizontal: screen.widthConverter(18.5)),
                        child: Column(
                          children: <Widget>[
                            SizedBox.fromSize(
                              size:
                                  Size.fromHeight(screen.heightConverter(200)),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: IgnorePointer(
                                  child: MyMap(horizontalListElement.latLng),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: screen.heightConverter(10))),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, MyMap.route,
                                      arguments: horizontalListElement.latLng);
                                },
                                child: Text(
                                  'show map',
                                  style: textTheme.body1.copyWith(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screen.widthConverter(18.5)),
                  child: Text(
                    horizontalListElement.highLights,
                    style: textTheme.body1,
                  ),
                ),
                // horizontalListElement.isRelatedEmpty
                //     ? SizedBox.shrink()
                //     : Padding(
                //         child: HorizontalListDash(
                //           horizontalListElement.related,
                //         ),
                //         padding:
                //             EdgeInsets.only(top: screen.heightConverter(10))),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screen.heightConverter(34.5),
                      horizontal: screen.widthConverter(18.5)),
                  child: FlatButton(
                    child: Text('Pay Now'),
                    onPressed: () {
                      Navigator.pushNamed(context, BookFlight.route,
                          arguments: {
                            'name': horizontalListElement.getTitle,
                            'tourId': horizontalListElement.id
                          });
                    },
                    color: theme.accentColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

/*
                related.isEmpty
                    ? SizedBox.shrink()
                    : Column(
                        children: <Widget>[
                          ListTitle(
                              Text(
                                'Related',
                                style: textTheme.body2,
                              ),
                              SizedBox.fromSize(
                                size: Size.fromHeight(
                                    screen.heightConverter(160)),
                                child: horizontalListElement
                                        .isRelatedReadyToDisplay
                                    ? ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screen.widthConverter(18.5)),
                                        physics: BouncingScrollPhysics(),
                                        itemCount: 8,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, int index) => InkWell(
                                          onTap: () {
                                            /*
                                Navigator.pushNamed(context, Info.route,
                                    arguments: InfoModel(
                                        ImageAndTextModel(imageUrl, title),
                                        otherImages,
                                        overView,
                                        highLights,
                                        related,
                                        latlng));
                                        */
                                          },
                                          child: SizedBox.fromSize(
                                            size: Size.fromWidth(
                                                screen.widthConverter(133.84)),
                                            child: ImageWithItsText(
                                              alignmentGeometry:
                                                  Alignment(0, 0.8),
                                              imageUrl: imageUrl,
                                              text: Text(
                                                'Hello world',
                                                style: textTheme.caption,
                                              ),
                                            ),
                                          ),
                                        ),
                                        separatorBuilder: (BuildContext context,
                                                int index) =>
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: screen
                                                        .widthConverter(13.6))),
                                      )
                                    : FutureBuilder<List<String>>(
                                        future: getRelated,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<String>>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            horizontalListElement
                                                .setModelDataResponse(context,
                                                    related: (snapshot.data));

                                            return ListView.separated(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: screen
                                                      .widthConverter(18.5)),
                                              physics: BouncingScrollPhysics(),
                                              itemCount: horizontalListElement
                                                  .modelDataResponse.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (_, int index) {
                                                var element =
                                                    horizontalListElement
                                                            .modelDataResponse[
                                                        index];
                                                var imageAndText =
                                                    element.imageAndTextModel;

                                                return InkWell(
                                                  onTap: () {
                                                    /*
                                            Navigator.pushNamed(
                                                context, Info.route,
                                                arguments: InfoModel.empty(
                                                    ImageAndTextModel(
                                                        imageAndText.imageUrl,
                                                        imageAndText.title),
                                                    element.otherImages,
                                                    element.overView,
                                                    element.highLights,
                                                    element.related,
                                                    element.latlng));
                                                    */
                                                  },
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromWidth(
                                                        screen.widthConverter(
                                                            133.84)),
                                                    child: ImageWithItsText(
                                                      alignmentGeometry:
                                                          Alignment(0, 0.8),
                                                      imageUrl:
                                                          imageAndText.image,
                                                      text: Text(
                                                        imageAndText.title,
                                                        style:
                                                            textTheme.caption,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: screen
                                                                  .widthConverter(
                                                                      13.6))),
                                            );
                                          } else {
                                            return Text('!!');
                                          }
                                        },
                                      ),
                              )),
                        ],
                      ),

                // Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: screen.widthConverter(18.5)),
                //   child: Text(
                //     "“Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem “Nor is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but occasionally circumstances occur in which toil and pain can procure him some great pleasure",
                //     style: textTheme.body1,
                //   ),
                // ),

                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text('a journey int the past',
                      style: textTheme.body2.copyWith(color: Colors.white)),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  MyRatingBar(screen.heightConverter(20)),
                  Spacer(
                    flex: 3,
                  ),

isLast
                    ? textTheme.caption
                        .copyWith(fontSize: ScreenUtil().setSp(20))
          twoLines
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello Castle',
                        style: textTheme.caption,
                      ),
                      Text('4 of your Friends',
                          style: textTheme.caption.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(12),
                              color: Colors.white.withOpacity(0.7)))
                    ],
                  ),
                )
              : Align(
                  alignment: isLast ? Alignment.center : Alignment(0, 0.8),
                  child: Text(
                    isLast ? '13+' : 'Riyadh',
                    style: isLast
                        ? textTheme.caption
                            .copyWith(fontSize: ScreenUtil().setSp(20))
                        : textTheme.caption,
                  ),
                )
   Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screen.widthConverter(18.5)),
              child: SizedBox.fromSize(
                size: Size.fromHeight(screen.heightConverter(200)),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 14,
                      child: ImageWithItsText(
                        alignmentGeometry: Alignment(0, 0.9),
                        imageUrl: imageUrl,
                        text: Text(
                          'Hello world',
                          style: textTheme.caption,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: screen.widthConverter(10.6))),
                    Flexible(
                      flex: 22,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ImageWithItsText(
                              imageUrl: imageUrl,
                              alignmentGeometry: Alignment(0, 0.5),
                              text: Text(
                                'Hello world',
                                style: textTheme.caption,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: screen.heightConverter(15.25))),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ImageWithItsText(
                                    alignmentGeometry: Alignment(0, 0.7),
                                    imageUrl: imageUrl,
                                    text: Text(
                                      'Hello world',
                                      style: textTheme.caption,
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: screen.widthConverter(10))),
                                Expanded(
                                  child: ImageWithItsText(
                                    opacity: 0.6,
                                    imageUrl: imageUrl,
                                    text: Text(
                                      '13+',
                                      style: textTheme.caption.copyWith(
                                          fontSize: ScreenUtil().setSp(20)),
                                    ),
                                  ),
                                  flex: 5,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

*/
