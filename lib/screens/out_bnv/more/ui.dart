import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/grid_card.dart';
import 'package:m/commons/widgets/search_field.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/screens/bnv/pages/trips/widgets/grid_cities_list.dart';
import 'package:m/screens/bnv/widget/logic.dart';
import 'package:m/screens/out_bnv/more/widgets/gridview.dart';
import 'package:provider/provider.dart';

import 'logic.dart';
import 'model.dart';

typedef Widget Body(dynamic param);

class MoreRoot extends StatelessWidget {
  static const route = '/more';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;

    // return More();
    return ChangeNotifierProvider(
      create: (ctx) => MoreLogic(),
      child: arguments['widget'],
    );
  }
}

class MoreOffline extends StatelessWidget {
  GridViewModel gridViewModel;
  MoreOffline(this.gridViewModel);
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<MoreLogic>(context, listen: true);
    Screen screen = Provider.of(context);
    logic.gridViewModel = gridViewModel;
    return gridViewModel.castedResponse.isEmpty
        ? Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.info,
                    size: 50.h,
                  ),
                  Padding(padding: EdgeInsets.only(top: 30.h)),
                  Text(
                    'Sorry this destination is empty now .. try again later',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: extended.NestedScrollView(
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
                                        top: screen.heightConverter(40),
                                        bottom: screen.heightConverter(0)),
                                    child: MySearchTextField(
                                      onChanged: (String text) =>
                                          logic.onChanged(context, text),
                                      controller: logic.searchController,
                                      edgeInsetsGeometry: EdgeInsets.symmetric(
                                          horizontal: screen.widthConverter(5),
                                          vertical: screen.heightConverter(10)),
                                      readOnly: false,
                                    )),
                              ),
                            ),
                            expandedHeight: screen.heightConverter(130),
                          )
                        ],
                body: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screen.widthConverter(19),
                        vertical: screen.heightConverter(20)),
                    child: logic.searchList.isEmpty &&
                            logic.searchController.text.isNotEmpty
                        ? Center(child: Text('Empty'))
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: logic.searchController.value.text.isEmpty
                                ? gridViewModel.castedResponse.length
                                : logic.searchList.length,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (screen.widthConverter(156) /
                                  screen.heightConverter(194)),
                              crossAxisSpacing: screen.widthConverter(16),
                              mainAxisSpacing: screen.heightConverter(13),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return MyGridCard(
                                  logic.searchController.value.text.isEmpty
                                      ? gridViewModel.castedResponse[index]
                                      : logic.searchList[index]);
                              // }
                            }))),
          );
  }
}

class MoreOnline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var logic = Provider.of<MoreLogic>(context, listen: false);
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    logic.id = arguments['id'];
    logic.request = logic.getRequest();
    return WillPopScope(
      onWillPop: () async {
        BnvLogic.restoreLanguage();
        return true;
      },
      child: MyFutureBuilder(
        request: logic.request,
        loading: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: MyGridView(
              myShimmer,
            ),
          ),
        ),
        fullResponse: (snapShot) {
          var gridViewModel = GridViewModel(context, snapShot.data);
          if (gridViewModel.castedResponse.isEmpty) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.info,
                      size: 50.h,
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.h)),
                    Text(
                      'Sorry this destination is empty now .. try again later',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: extended.NestedScrollView(
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
                                        top: screen.heightConverter(40),
                                        bottom: screen.heightConverter(0)),
                                    child: MySearchTextField(
                                      onChanged: (String text) =>
                                          logic.onChanged(context, text),
                                      controller: logic.searchController,
                                      edgeInsetsGeometry: EdgeInsets.symmetric(
                                          horizontal: screen.widthConverter(5),
                                          vertical: screen.heightConverter(10)),
                                      readOnly: false,
                                    )),
                              ),
                            ),
                            expandedHeight: screen.heightConverter(130),
                          )
                        ],
                body: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screen.widthConverter(19),
                        vertical: screen.heightConverter(20)),
                    child: NormalGridView(gridViewModel))),
          );
        },
      ),
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
        body: extended.NestedScrollView(
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
                                    top: screen.heightConverter(40),
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
                        expandedHeight: screen.heightConverter(130),
                      )
                    ],
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screen.widthConverter(19),
                  vertical: screen.heightConverter(20)),
              child: body,
            )),
      ),
    );
  }
}
