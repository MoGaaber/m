import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/screens/bnv/pages/trips/logic.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:provider/provider.dart';

class GridTripsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    TextTheme textTheme = theme.textTheme;
    var screen = Provider.of<Screen>(context);
    var logic = Provider.of<TripsLogic>(context, listen: true);
    return MyFutureBuilder<Response<Map<String, dynamic>>>(
        request: logic.getWonderful,
        fullResponse: (snapShot) {
          HorizontalListElements horizontalListModel =
              HorizontalListElements(context, snapShot.data);
          var castedResponse = horizontalListModel.castedResponse;
          return ListTitle(
              Text(horizontalListModel.header, style: textTheme.body2),
              Padding(
                padding: EdgeInsets.only(
                  left: screen.widthConverter(19),
                  right: screen.widthConverter(19),
                  bottom: screen.heightConverter(120),
                ),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: castedResponse.length,
                  itemBuilder: (BuildContext context, int index) {
                    var element = castedResponse[index];
                    return InkWell(
                      onTap: () {
                        logic.onTap(context, element);
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screen.widthConverter(10))),
                              child: Image.network(
                                element.mainImagePath,
                                fit: BoxFit.cover,
                                height: 160.h,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    element.getTitle,
                                    textWidthBasis: TextWidthBasis.parent,
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.body1,
                                  ),
                                ),
                                Text(
                                  element.adultPrice + r' $',
                                  maxLines: 1,
                                  style: textTheme.body2,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            element.getOverView.isEmpty
                                ? SizedBox.shrink()
                                : Text(element.getOverView,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.body1.copyWith(
                                        fontFamily: 'RobotoSlab',
                                        color: Color(0xff5C6979),
                                        fontSize: (10.sp))),
                          ]),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screen.widthConverter(16),
                    mainAxisSpacing: screen.heightConverter(0),
                    childAspectRatio: screen.widthConverter(158) /
                        screen.heightConverter(250),
                  ),
                ),
              ));
        },
        loading: ListTitle(
            SizedBox(
              child: myShimmer(context: context),
              width: (screen.widthConverter(220)),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) =>
                  myShimmer(context: context),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: screen.widthConverter(16),
                mainAxisSpacing: screen.heightConverter(20),
                childAspectRatio:
                    screen.widthConverter(158) / screen.heightConverter(200),
              ),
            )));
  }
}
