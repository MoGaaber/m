import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/search_field.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:m/screens/bnv/widget/logic.dart';

import 'package:provider/provider.dart';

import 'logic.dart';

typedef Widget Body(dynamic param);

class MoreRoot extends StatelessWidget {
  static const route = '/more';

  @override
  Widget build(BuildContext context) {
    // return More();
    return ChangeNotifierProvider(
      create: (ctx) => MoreLogic(),
      child: More(),
    );
  }
}

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    Widget body = ModalRoute.of(context).settings.arguments;

    var logic = Provider.of<MoreLogic>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        BnvLogic.restoreLanguage();
        return true;
      },
      child: Scaffold(
          body: NestedScrollViewRefreshIndicator(
        onRefresh: () {},
        child: extended.NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
                      SliverAppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        floating: true,
                        snap: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Center(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: screen.widthConverter(25),
                                    right: screen.widthConverter(25),
                                    top: screen.heightConverter(10),
                                    bottom: screen.heightConverter(0)),
                                child: MySearchTextField(
                                  onChanged: (String text) =>
                                      logic.onChanged(context, text),
                                  controller: logic.searchController,
                                  // edgeInsetsGeometry: EdgeInsets.symmetric(
                                  //     vertical: screen.heightConverter(10)),
                                  readOnly: false,
                                )),
                          ),
                        ),
                        expandedHeight: screen.heightConverter(120),
                      )
                    ],
            body: body),
      )),
    );
  }
}
