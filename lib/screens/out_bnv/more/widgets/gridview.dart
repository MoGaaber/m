import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/grid_card.dart';
import 'package:m/screens/out_bnv/more/model.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class NormalGridView extends StatelessWidget {
  final GridViewModel gridViewModel;
  NormalGridView(this.gridViewModel);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var logic = Provider.of<MoreLogic>(context, listen: true);
    logic.gridViewModel = gridViewModel;
    return gridViewModel.castedResponse.isEmpty
        ? Center(
            child: Text(
              'empty',
            ),
          )
        : logic.searchList.isEmpty && logic.searchController.text.isNotEmpty
            ? Center(child: Text('Empty'))
            : GridView.builder(
                shrinkWrap: true,
                itemCount: logic.searchController.value.text.isEmpty
                    ? gridViewModel.castedResponse.length
                    : logic.searchList.length,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (screen.widthConverter(156) /
                      screen.heightConverter(194)),
                  crossAxisSpacing: screen.widthConverter(16),
                  mainAxisSpacing: screen.heightConverter(13),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return MyGridCard(logic.searchController.value.text.isEmpty
                      ? gridViewModel.castedResponse[index]
                      : logic.searchList[index]);
                  // }
                });
  }
}
//logic.searchController.text.isEmpty
//: logic.searchResult[index].horizontalListElement
