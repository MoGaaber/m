import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/screens/bnv/pages/search/image.dart';
import 'package:m/screens/bnv/pages/search/model.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class SearchRoot extends StatefulWidget {
  @override
  _SearchRootState createState() => _SearchRootState();
}

class _SearchRootState extends State<SearchRoot>
    with AutomaticKeepAliveClientMixin<SearchRoot> {
  @override
  Widget build(BuildContext ctx) {
    super.build(ctx);
    return Search();
  }

  @override
  bool get wantKeepAlive => true;
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(
      context,
    );
    var logic = Provider.of<SearchLogic>(context, listen: true);
    var localization = Localization.of(context).search;
    return Padding(
      padding: EdgeInsets.only(
          top: screen.heightConverter(10),
          left: screen.widthConverter(20),
          right: screen.widthConverter(20)),
      child: Column(
        children: <Widget>[
          Directionality(
            textDirection: logic.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: MyTextField(
              localization[0],
              onChanged: (input) {
                logic.onChangeSearchText(context, input);
              },
              controller: logic.textEditingController,
              suffix: GestureDetector(
                onTap: logic.clearSearchField,
                child: Icon(
                  Icons.close,
                  size: screen.aspectRatioConverter(28),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: screen.heightConverter(10),
                  horizontal: screen.widthConverter(10)),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: screen.heightConverter(16))),
          Expanded(
              child: logic.textEditingController.text.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.searchMinus,
                          size: 60.h,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.h)),
                        Text(localization[1]),
                      ],
                    )
                  : MyFutureBuilder<Response<Map<String, dynamic>>>(
                      request: logic.getSearchResult,
                      empty: Text('networdl'),
                      serverError: Text('networdl'),
                      networkError: Text('networdl'),
                      fullResponse: (snapshot) {
                        logic.searchModel = SearchModel(context, snapshot.data);
                        var searchResult = logic.searchModel.castedResponse;
                        if (searchResult.isEmpty) {
                          return Center(
                            child: Text('Empty search result '),
                          );
                        }
                        return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                            physics: BouncingScrollPhysics(),
                            itemCount: searchResult.length,
                            itemBuilder: (_, int index) {
                              var element = searchResult[index];
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    subtitle: Text(
                                      element.adultPrice.toString() + r"$",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    leading: MyImage(searchResult, index),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, InfoRoot.route,
                                          arguments: element);
                                    },
                                    title: Text(
                                      searchResult[index].getTitle,
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      loading: ListView.builder(
                        itemBuilder: (_, int index) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screen.heightConverter(10)),
                          child: SizedBox.fromSize(
                              size: Size.fromHeight(screen.heightConverter(50)),
                              child: myShimmer(context: context)),
                        ),
                        itemCount: 10,
                      ))),
          Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screen.heightConverter(10)))
        ],
      ),
    );
  }
}
