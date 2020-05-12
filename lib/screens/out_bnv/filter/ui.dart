import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/screens/out_bnv/filter/model.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'logic.dart';

class Filter extends StatelessWidget {
  static const route = '/filters';

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<FilterLogic>(context, listen: false);
    print('!');
    var screen = Provider.of<Screen>(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    var localization = Localization.of(context).filter;
    return Scaffold(
      body: Selector<FilterLogic,
          Tuple2<bool, Future<List<Response<Map<String, dynamic>>>>>>(
        selector: (BuildContext, FilterLogic filterLogic) =>
            Tuple2(filterLogic.clearFilterState, filterLogic.apiRequest),
        builder: (BuildContext context, value, Widget child) {
          print('heeeuu');
          return MyFutureBuilder<List<Response<Map<String, dynamic>>>>(
              request: value.item2,
              empty: Text('networdl'),
              serverError: Text('networdl'),
              networkError: Text('networdl'),
              fullResponse: (snapshot) {
                logic.attachData(context, snapshot);
                var filterModel = logic.filterModel;
                return RefreshIndicator(
                  onRefresh: logic.refresh,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screen.widthConverter(18)),
                        child: Text(
                          localization[0],
                          style: textTheme.display2,
                        ),
                      ),
                      B(
                          localization[1],
                          HirozSelectList(
                              filterModel.cities, logic.selectCities)),
                      B(
                          localization[2],
                          HirozSelectList(
                              filterModel.features, logic.selectFeatures)),
                      B(
                        localization[3],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screen.widthConverter(27)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    r'0$',
                                    style: textTheme.subtitle,
                                  ),
                                  Text(
                                    filterModel.maxPrice.toString() + r'$',
                                    style: textTheme.subtitle,
                                  )
                                ],
                              ),
                            ),
                            SizedBox.fromSize(
                              child: Selector<FilterLogic, RangeValues>(
                                builder: (__, RangeValues value, _) => Column(
                                  children: <Widget>[
                                    RangeSlider(
                                        activeColor:
                                            Theme.of(context).accentColor,
                                        max: filterModel.maxPrice.toDouble(),
                                        min: 0,
                                        values: value,
                                        onChanged: logic.onChangeRange),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              screen.widthConverter(27)),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '${localization[4]}: ',
                                            style: textTheme.subtitle.copyWith(
                                                color: theme.primaryColorDark),
                                          ),
                                          Text(
                                              logic.filterModel.priceRange.start
                                                      .toInt()
                                                      .toString() +
                                                  r'$' +
                                                  ' - ' +
                                                  logic.filterModel.priceRange
                                                      .end
                                                      .toInt()
                                                      .toString() +
                                                  r'$',
                                              style: textTheme.subtitle
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: theme
                                                          .primaryColorDark))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                selector: (_, FilterLogic filterLogic) =>
                                    filterLogic.filterModel.priceRange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screen.widthConverter(30),
                            right: screen.widthConverter(30),
                            top: screen.heightConverter(80)),
                        child: FlatButton(
                          disabledColor: theme.disabledColor,
                          onPressed: () {
                            logic.filter(context);
                          },
                          child: Text(localization[5]),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      FlatButton(
                        onPressed: logic.clearFilter,
                        child: Text(localization[6]),
                        textColor: theme.primaryColorDark,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                        bottom: screen.heightConverter(50),
                      ))
                    ],
                  ),
                );
              },
              loading: Center(
                child: CircularProgressIndicator(),
              ));
        },
      ),
      appBar: AppBar(),
    );
  }
}

class B extends StatelessWidget {
  final String text;
  final Widget body;
  B(this.text, this.body);
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              right: screen.widthConverter(18),
              left: screen.widthConverter(18),
              top: screen.heightConverter(21),
              bottom: screen.heightConverter(12)),
          child: Text(this.text, style: textTheme.body2),
        ),
        body,
      ],
    );
  }
}

typedef TabOnSelectList(int index);

class HirozSelectList extends StatelessWidget {
  final List<FilterElement> list;
  final TabOnSelectList tabOnSelectList;

  HirozSelectList(this.list, this.tabOnSelectList);
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var logic = Provider.of<FilterLogic>(context, listen: false);

    return SizedBox.fromSize(
        size: Size.fromHeight(screen.heightConverter(40)),
        child: ListView.builder(
          padding: EdgeInsets.only(left: screen.widthConverter(18)),
          itemCount: this.list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              Selector<FilterLogic, bool>(
            builder: (BuildContext context, bool value, Widget child) {
              return Padding(
                  padding: EdgeInsets.only(
                    right: screen.widthConverter(15),
                  ),
                  child: InkWell(
                      onTap: () {
                        this.tabOnSelectList(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xffF1F3F6),
                            border: list[index].selected
                                ? Border.all(
                                    width: screen.widthConverter(2),
                                    color: Theme.of(context).accentColor)
                                : null,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screen.widthConverter(10),
                              vertical: screen.heightConverter(11)),
                          child: Text(
                            list[index].name,
                            style: GoogleFonts.robotoSlab(
                                fontSize: screen.aspectRatioConverter(12)),
                          ),
                        ),
                      )));
            },
            selector: (BuildContext, filterLogic) => list[index].selected,
          ),
        ));
  }
}
// child: OutlineButton(
//   shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(
//           Radius.circular(screen.aspectRatioConverter(10)))),
//   borderSide: BorderSide(
//       style: BorderStyle.solid,
//       color: Theme.of(context).accentColor,
//       width: screen.widthConverter(2)),
//   color: Colors.black,
//   onPressed: () {
//     print(list[index].name);
//   },
//   textColor: Color(0xff323B45),
//   child: Text(
//     list[index].name,
//     style: GoogleFonts.robotoSlab(
//         fontSize: screen.aspectRatioConverter(12)),
//   ),
// ),
/*
          child: InkWell(
            onTap: () {},
            child: Material(
              color: Color(0xffF1F3F6),

              // decoration: BoxDecoration(
              //     shape: BoxShape.rectangle,
              /*
                  border: Border.all(
                      width: screen.widthConverter(2),
                      color: Theme.of(context).accentColor),
                      */
              // borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(10),
                    vertical: screen.heightConverter(11)),
                child: Text(
                  list[index].name,
                  style: GoogleFonts.robotoSlab(
                      fontSize: screen.aspectRatioConverter(12)),
                ),
              ),
            ),
          ),
          */
