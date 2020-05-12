import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class BnvRoot extends StatelessWidget {
  static const route = '/bnv';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BnvLogic(),
      child: Bnv(),
    );
  }
}

class Bnv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = (Provider.of<Screen>(context));
    final logic = Provider.of<BnvLogic>(context, listen: false);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: PageView.builder(
          controller: logic.pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) =>
              logic.bnv[index].body,
        ),
      ),
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
                builder: (BuildContext context, int value, Widget child) =>
                    InkWell(
                        child: AnimatedPadding(
                          padding: EdgeInsets.only(
                              bottom: logic.bnv[i].selected ? 10 : 0),
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
    );
  }
}
