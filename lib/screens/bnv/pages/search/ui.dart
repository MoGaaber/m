import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/text_field.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/constants/constants.dart';
import 'package:m/screens/bnv/pages/search/image.dart';
import 'package:m/screens/bnv/pages/search/model.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:m/screens/bnv/widget/logic.dart';
import 'package:m/screens/out_bnv/info/ui.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class SearchRoot extends StatelessWidget {
//   @override
//   _SearchRootState createState() => _SearchRootState();
// }

// class _SearchRootState extends State<SearchRoot>
//     with AutomaticKeepAliveClientMixin<SearchRoot> {
  @override
  Widget build(BuildContext ctx) {
    print('!!!!!!');
    // super.build(context);
    return ChangeNotifierProvider(
      child: Search(),
      create: (BuildContext context) => SearchLogic(ctx),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(
      context,
    );
    CompleteElementModel.context = context;
    var logic = Provider.of<SearchLogic>(context, listen: true);
    return Padding(
      padding: EdgeInsets.only(
          top: screen.heightConverter(10),
          left: screen.widthConverter(20),
          right: screen.widthConverter(20)),
      child: Column(
        children: <Widget>[
          Directionality(
            textDirection: logic.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: MyTextField(Localization.of(context).search,
                onChanged: (input) {
              logic.onChangeSearchText(context, input);
            },
                controller: logic.textEditingController,
                suffix: InkWell(
                  onTap: () {
                    logic.clearSearchField();
                  },
                  child: GestureDetector(
                    onTap: () {
                      logic.clearSearchField();
                      print('hellooo');
                    },
                    child: Icon(
                      Icons.close,
                      size: screen.aspectRatioConverter(28),
                    ),
                  ),
                  // contentPadding: EdgeInsets.symmetric(
                  //     vertical: screen.heightConverter(10),
                  //     horizontal: screen.widthConverter(10)),
                )),
          ),
          Padding(padding: EdgeInsets.only(top: screen.heightConverter(16))),
          Expanded(
              child: logic.textEditingController.text.isEmpty
                  ? Center(child: Text('empty query'))
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
                            itemBuilder: (BuildContext context, int index) {
                              var element = searchResult[index];
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    subtitle: Text(
                                      element.adultPrice + r"$",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    trailing: MyImage(searchResult, index),
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
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
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
