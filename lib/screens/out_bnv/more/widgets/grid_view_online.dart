import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m/commons/widgets/future_builder.dart';
import 'package:m/commons/widgets/title_and_show_more.dart';
import 'package:m/constants/apis_url.dart';
import 'package:m/screens/bnv/pages/trips/widgets/grid_list.dart';
import 'package:m/screens/out_bnv/more/widgets/gridview.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class GridViewOnline extends StatelessWidget {
  int id;
  GridViewOnline(this.id);

  void refresh() {}

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<MoreLogic>(context, listen: false);
    logic.id = id;
    logic.request = Dio().get(ApisUrls.more + '/$id');

    return Selector<MoreLogic, Future>(
        builder: (BuildContext context, Future value, Widget child) {
          return MyFutureBuilder<Response<Map<String, dynamic>>>(
              request: logic.request,
              empty: Text('networdl'),
              serverError: Text('networdl'),
              networkError: Text('networdl'),
              fullResponse: (snapshot) {
                return NormalGridView(snapshot.data);
              },
              loading: MyGridView(
                myShimmer,
              ));
        },
        selector: (BuildContext, MoreLogic moreLogic) => moreLogic.request);

    ;
  }
}
