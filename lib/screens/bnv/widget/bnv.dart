import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/bnv/pages/profile/logic.dart';
import 'package:m/screens/bnv/pages/search/logic.dart';
import 'package:m/screens/bnv/pages/trips/logic.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class BnvRoot extends StatelessWidget {
  static const route = '/bnv';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: Bnv(),
      create: (BuildContext context) => BnvLogic(),
    );
  }
}

class NetworkError extends StatelessWidget {
  final VoidCallback onTap;
  NetworkError(this.onTap);
  @override
  Widget build(BuildContext context) {
    final screen = (Provider.of<Screen>(context));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Spacer(
            flex: 3,
          ),
          Icon(
            FontAwesomeIcons.wifi,
            size: screen.heightConverter(80),
          ),
          Spacer(
            flex: 2,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: screen.widthConverter(40)),
            child: FlatButton(
                onPressed: this.onTap,
                color: Theme.of(context).accentColor,
                child: Text('Reload')),
          ),
          Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}

class Bnv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = (Provider.of<Screen>(context));
    final logic = Provider.of<BnvLogic>(context, listen: false);

    return Selector<BnvLogic, Future<bool>>(
      selector: (BuildContext, BnvLogic bnvLogic) => bnvLogic.realNetConnection,
      builder: (BuildContext context, Future value, Widget child) {
        return FutureBuilder<bool>(
          future: logic.realNetConnection,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.data) {
                return NetworkError(logic.refetchRealNetConnection);
              }
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (BuildContext context) => TripsLogic(),
                  ),
                  ChangeNotifierProvider(
                    create: (BuildContext context) => ProfileLogic(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => SearchLogic(context),
                  ),
                ],
                child: Scaffold(
                  bottomNavigationBar: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: screen.aspectRatioConverter(10),
                          spreadRadius: screen.aspectRatioConverter(5),
                          color: Colors.black.withOpacity(0.1))
                    ], color: Colors.white),
                    height: screen.heightConverter(50),
                    // color: Color(0xffF4F4F4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        for (int i = 0; i < logic.bnv.length; i++)
                          Selector<BnvLogic, int>(
                            builder: (BuildContext context, int value,
                                    Widget child) =>
                                InkWell(
                                    child: AnimatedPadding(
                                      padding: EdgeInsets.only(
                                          bottom:
                                              logic.bnv[i].selected ? 10 : 0),
                                      child: Icon(logic.bnv[i].icon,
                                          size: screen.heightConverter(22),
                                          color: logic.bnv[i].color(context)),
                                      duration: Duration(milliseconds: 100),
                                    ),
                                    onTap: () {
                                      logic.onTap(i, context);
                                    }),
                            selector: (_, BnvLogic logic) => logic.currentIndex,
                          ),
                      ],
                    ),
                  ),
                  body: PageView.builder(
                    controller: logic.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        logic.bnv[index].body,
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
/*
*/
