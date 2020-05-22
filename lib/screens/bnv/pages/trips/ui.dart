import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/search_field.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/main.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:m/screens/bnv/pages/trips/widgets/grid_list.dart';
import 'package:m/screens/bnv/pages/trips/widgets/hiroz_list.dart';
import 'package:m/screens/bnv/widget/bnv.dart';
import 'package:m/screens/bnv/widget/logic.dart';
import 'package:m/screens/out_bnv/filter/ui.dart';
import 'package:provider/provider.dart';

import 'logic.dart';
import 'widgets/carousel_list.dart';

class Trips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var logic = Provider.of<TripsLogic>(context, listen: true);
    return logic.haveNetWorkError
        ? NetworkError(logic.fetchApi)
        : RefreshIndicator(
            onRefresh: logic.fetchApi,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  snap: true,
                  floating: true,
                  actions: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(right: screen.widthConverter(10)),
                      child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.slidersH,
                            color: Color(0xff323B45),
                            size: screen.heightConverter(20),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Filter.route);
                          }),
                    )
                  ],
                  centerTitle: true,
                  title: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fitHeight,
//            width: 40,
                    height: screen.heightConverter(21),
                  ),
                  // title: Text('Touri'),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                  [
                    Padding(
                        padding:
                            EdgeInsets.only(top: screen.heightConverter(10))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screen.widthConverter(7.5)),
                      child: Container(
                        color: Colors.transparent,
                        child: SizedBox.fromSize(
                          size: Size.fromHeight(screen.heightConverter(280)),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              CarouselList(),
                              Positioned(
                                bottom: screen.heightConverter(5),
                                height: screen.heightConverter(70),
                                width: screen.widthConverter(300),
                                left: screen.widthConverter(30),
                                child: MySearchTextField(
                                  readOnly: true,
                                  onTap: () {
                                    Provider.of<BnvLogic>(context,
                                            listen: false)
                                        .toSearchPage();
                                  },
                                ),
                              )
                              // */
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridList(),
                    HorizontalList(logic.getPopular, horizontalListViewItem),
                    HorizontalList(
                        logic.getRecommended, horizontalListViewItem),
                    HorizontalList(logic.getWonderful, horizontalListViewItem),
                    Padding(
                        padding:
                            EdgeInsets.only(bottom: screen.heightConverter(50)))
                  ],
                )),
              ],
            ),
          );
  }
}

class TripsRoot extends StatefulWidget {
  static const route = '/trips';

  @override
  _TripsRootState createState() => _TripsRootState();
}

class _TripsRootState extends State<TripsRoot>
    with AutomaticKeepAliveClientMixin<TripsRoot> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Trips();
  }

  @override
  bool get wantKeepAlive => true;
}
