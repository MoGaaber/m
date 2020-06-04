import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m/COMMONS/widgets/title_and_show_more.dart';
import 'package:m/commons/models/image_and_text._model.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/image_with_text.dart';
import 'package:m/screens/bnv/pages/trips/models/grid_list.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class GridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    var logic = Provider.of<TripsLogic>(context, listen: false);
    return MyFutureBuilder<Response<Map<String, dynamic>>>(
        request: logic.getTopDestinations,
        empty: Text('networdl'),
        serverError: Text('networdl'),
        networkError: Text('networdl'),
        fullResponse: (snapshot) {
          GridListModel gridListModel = GridListModel(context, snapshot.data);
          return Column(
            children: <Widget>[
              ListTitle(
                Text(
                  gridListModel.header,
                  style: textTheme.body2,
                ),
                MyGridView(gridViewItem, data: gridListModel.castedResponse),
                top: 10,
              )
            ],
          );
        },
        loading: ListTitle(
            myShimmer(context: context),
            MyGridView(
              myShimmer,
            )));
  }
}

// padding:
//     EdgeInsets.symmetric(horizontal: screen.widthConverter(16.66)),
class MyGridView extends StatelessWidget {
  final List<ImageAndTextModelWithId> data;
  final Item item;
  MyGridView(this.item, {this.data});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: screen.widthConverter(16.66)),
        child: GridView.builder(
            itemCount: data?.length ?? 6,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: screen.widthConverter(7.16),
              mainAxisSpacing: screen.widthConverter(7.16),
              crossAxisCount: 2,
              childAspectRatio:
                  screen.widthConverter(166.84) / screen.heightConverter(161),
            ),
            itemBuilder: (BuildContext context, int index) =>
                this.item(context: context, index: index, data: data)));
  }
}

Widget gridViewItem({BuildContext context, List data, int index, void cast}) {
  ThemeData theme = Theme.of(context);
  TextTheme textTheme = theme.textTheme;
  TripsLogic logic = Provider.of(context);
//  return MyImage(
//      data[index].title, data[index].mainImage, data, logic.onTapGridList);

  return ImageWithItsText(
    onTap: () {
      logic.onTapGridList(context, data[index].id);
    },
    imageUrl: data[index].mainImage,
    alignmentGeometry: Alignment(0, 0.90),
    text: Text(
      data[index].title,
      style: textTheme.caption,
      textAlign: TextAlign.center,
    ),
  );
}
