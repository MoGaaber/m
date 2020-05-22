import 'package:flutter/material.dart';
import 'package:m/commons/utils/localization/localization.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/commons/widgets/grid_card.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:m/screens/bnv/pages/trips/widgets/grid_list.dart';
import 'package:provider/provider.dart';
import '../logic.dart';
import 'package:m/screens/out_bnv/more/model.dart';

class NormalGridView extends StatelessWidget {
  final Map<String, dynamic> data;
  NormalGridView(this.data);
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    var logic = Provider.of<MoreLogic>(context, listen: false);
    logic.gridViewModel = GridViewModel(context, this.data);
    return Consumer<MoreLogic>(
      builder: (BuildContext context, MoreLogic logic, Widget child) => logic
              .gridViewModel.castedResponse.isEmpty
          ? Center(
              child: Text('!!'),
            )
          : logic.searchList.isEmpty && logic.searchController.text.isNotEmpty
              ? Center(child: Text('Empty'))
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: logic.searchController.value.text.isEmpty
                      ? logic.gridViewModel.castedResponse.length
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
                        ? logic.gridViewModel.castedResponse[index]
                        : logic.searchList[index]);
                    // }
                  }),
    );
  }
}
//logic.searchController.text.isEmpty
//: logic.searchResult[index].horizontalListElement
