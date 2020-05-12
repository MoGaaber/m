import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/image_with_text.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/bnv/pages/search/model.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
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
            myShimmer(context: context),
            MyHorizontalListView(
              myShimmer,
            )));

    ;
  }
}

/*
*/
class MyHorizontalListView extends StatelessWidget {
  final List<CompleteElementModel> data;
  final Item<CompleteElementModel> item;

  MyHorizontalListView(this.item, {this.data});
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);

    return SizedBox.fromSize(
      size: Size.fromHeight(screen.heightConverter(161)),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(16)),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => SizedBox.fromSize(
          child: this.item(
            context: context,
            data: data,
            index: index,
          ),
          size: Size.fromWidth(
            screen.widthConverter(133),
          ),
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
  return ImageWithItsText(
    onTap: () {
      Navigator.pushNamed(context, InfoRoot.route, arguments: element);
    },
    imageUrl: element.mainImagePath,
    alignmentGeometry: Alignment(0, 0.90),
    text: Text(
      element.getTitle,
      style: textTheme.caption,
    ),
  );
}

horizontalListViewItemOnline(
    {BuildContext context, List<dynamic> data, int index, void cast}) {
  var themeData = Theme.of(context);
  var textTheme = themeData.textTheme;
  var element = data[index];
  return FutureBuilder<Response<Map<String, dynamic>>>(
    future: Dio().get(ApisUrls.info + element['tour_id']),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        var horizontalListElement =
            CompleteElementModel.fromJson(snapshot.data.data['success']);
        return ImageWithItsText(
          onTap: () {
            Navigator.pushNamed(context, InfoRoot.route,
                arguments: horizontalListElement);
          },
          imageUrl: horizontalListElement.mainImagePath,
          alignmentGeometry: Alignment(0, 0.90),
          text: Text(
            horizontalListElement.getTitle,
            style: textTheme.caption,
          ),
        );
      } else {
        return myShimmer(context: context);
      }
    },
  );
}
