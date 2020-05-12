import 'package:flutter/material.dart';
import 'package:m/commons/models/complete_element.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:m/screens/bnv/pages/search/logic.dart';
import 'package:m/screens/bnv/pages/trips/models/hiroz_list.dart';
import 'package:provider/provider.dart';

class MyImage extends StatelessWidget {
  final List<CompleteElementModel> modelDataResponse;
  final int index;
  MyImage(this.modelDataResponse, this.index);

  @override
  Widget build(BuildContext context) {
    var screen = Provider.of<Screen>(context);
    var logic = Provider.of<SearchLogic>(context);

    return ClipRRect(
      borderRadius:
          BorderRadius.all(Radius.circular(screen.aspectRatioConverter(10))),
      child: Image.network(
        modelDataResponse[index].mainImagePath,
        fit: BoxFit.cover,
        height: screen.heightConverter(60),
        width: screen.widthConverter(50),
      ),
    );
  }
}
