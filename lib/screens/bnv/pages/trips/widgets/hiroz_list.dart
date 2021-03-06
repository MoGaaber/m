import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class HorizontalList extends StatelessWidget {
  final Future getRequest;
  final Item<CompleteElementModel> item;

  HorizontalList(this.getRequest, this.item);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    var screen = Provider.of<Screen>(context);

    return MyFutureBuilder<Response<Map<String, dynamic>>>(
        request: getRequest,
        empty: Text('networdl'),
        serverError: Text('networdl'),
        networkError: Text('networdl'),
        fullResponse: (snapshot) {
          HorizontalListElements horizontalListModel =
              HorizontalListElements(context, snapshot.data);
          return ListTitle(
              Text(horizontalListModel.header, style: textTheme.body2),
              MyHorizontalListView(
                item,
                data: horizontalListModel.castedResponse,
              ));
        },
        loading: ListTitle(
            SizedBox(
              child: myShimmer(context: context),
              width: (screen.widthConverter(220)),
            ),
            MyHorizontalListView(
              myShimmer,
              widget: Padding(
                padding: EdgeInsets.only(top: screen.heightConverter(10)),
                child: SizedBox(
                  child: myShimmer(context: context),
                  width: screen.widthConverter(100),
                ),
              ),
            )));

    ;
  }
}

class MyHorizontalListView extends StatelessWidget {
  final List<CompleteElementModel> data;
  final Item<CompleteElementModel> item;
  final Widget widget;
  MyHorizontalListView(this.item,
      {this.data, this.widget = const SizedBox.shrink()});
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var logic = Provider.of<TripsLogic>(context);
    return SizedBox.fromSize(
      size: Size.fromHeight(screen.heightConverter(170)),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(16)),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: SizedBox.fromSize(
                child: this.item(
                  context: context,
                  data: data,
                  index: index,
                ),
                size: Size.fromWidth(
                  screen.widthConverter(133),
                ),
              ),
            ),
            widget
          ],
        ),
        itemCount: data?.length ?? 10,
        separatorBuilder: (BuildContext context, int index) => Padding(
            padding:
                EdgeInsets.symmetric(horizontal: screen.widthConverter(10))),
      ),
    );
  }
}

Widget horizontalListViewItem(
    {BuildContext context,
    List<CompleteElementModel> data,
    int index,
    void cast}) {
  var themeData = Theme.of(context);
  var textTheme = themeData.textTheme;
  var element = data[index];
  var screen = Provider.of<Screen>(context);
  var logic = Provider.of<TripsLogic>(context);
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        logic.onTap(context, element);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(screen.aspectRatioConverter(20))),
              child: ExtendedImage.network(
                data[index].mainImagePath,
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
                      child: Center(
                        child: ButtonTheme(
                          textTheme: ButtonTextTheme.primary,
                          minWidth: screen.widthConverter(80),
                          height: screen.heightConverter(40),
                          child: Center(
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            screen.aspectRatioConverter(10)))),
                                color: themeData.accentColor,
                                onPressed: state.reLoadImage,
                                child: Text(
                                  'reload',
                                  style: textTheme.caption,
                                )),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screen.heightConverter(5)),
            child: AutoSizeText(
              element.getTitle,
              maxLines: 1,
              maxFontSize: textTheme.caption.fontSize.roundToDouble(),
              overflow: TextOverflow.ellipsis,
              style: textTheme.caption.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}
